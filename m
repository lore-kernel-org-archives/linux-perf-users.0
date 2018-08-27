From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
Date: Mon, 27 Aug 2018 10:38:52 +0200
Message-ID: <20180827083852.GF24695@krava>
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

>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
>  				    bool overwrite)
>  {
>  	u64 bytes_written = rec->bytes_written;
> -	int i;
> -	int rc = 0;
> +	int i, rc = 0;
>  	struct perf_mmap *maps;
> +	int trace_fd = rec->session->data->file.fd;
> +	struct aiocb **mmap_aio = rec->evlist->mmap_aio;
> +	int mmap_aio_size = 0;
> +	off_t off;
>  
>  	if (!evlist)
>  		return 0;
> @@ -546,14 +620,17 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
>  		return 0;
>  
> +	off = lseek(trace_fd, 0, SEEK_CUR);
> +

with async write, do we need to query/set the offset like this
all the time?

could we just keep/update the offset value in the 'struct perf_data_file'
and skip both lseek calls?

jirka

SNIP

>  
> +	record__mmap_read_sync(trace_fd, mmap_aio, mmap_aio_size, rec);
> +
> +	lseek(trace_fd, off, SEEK_SET);
> +
