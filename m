From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
Date: Mon, 27 Aug 2018 10:34:57 +0200
Message-ID: <20180827083457.GE24695@krava>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Thu, Aug 23, 2018 at 07:47:01PM +0300, Alexey Budankov wrote:

SNIP

> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index e71d46cb01cc..c8b921c88a5d 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -292,11 +292,11 @@ int perf_mmap__read_init(struct perf_mmap *map)
>  }
>  
>  int perf_mmap__push(struct perf_mmap *md, void *to,
> -		    int push(void *to, void *buf, size_t size))
> +		    int push(void *to, void *buf, size_t size, off_t), off_t *off)
>  {
>  	u64 head = perf_mmap__read_head(md);
>  	unsigned char *data = md->base + page_size;
> -	unsigned long size;
> +	unsigned long size, size0 = 0;
>  	void *buf;
>  	int rc = 0;
>  
> @@ -308,23 +308,22 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>  
>  	if ((md->start & md->mask) + size != (md->end & md->mask)) {
>  		buf = &data[md->start & md->mask];
> -		size = md->mask + 1 - (md->start & md->mask);
> -		md->start += size;
> -
> -		if (push(to, buf, size) < 0) {
> -			rc = -1;
> -			goto out;
> -		}
> +		size0 = md->mask + 1 - (md->start & md->mask);
> +		md->start += size0;
> +		memcpy(md->data, buf, size0);
>  	}
>  
>  	buf = &data[md->start & md->mask];
>  	size = md->end - md->start;
>  	md->start += size;
> +	memcpy(md->data + size0, buf, size);

this will need more comments.. and explanation why we copy the data
over to another buffer.. it's interesting, it's still faster 

jirka
