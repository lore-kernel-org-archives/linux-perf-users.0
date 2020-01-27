From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] tools lib api fs: Move cgroupsfs_find_mountpoint()
Date: Mon, 27 Jan 2020 12:12:34 +0100
Message-ID: <20200127111234.GA1114818@krava>
References: <20200127100031.1368732-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200127100031.1368732-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jan 27, 2020 at 07:00:31PM +0900, Namhyung Kim wrote:

SNIP

> -
> -	if (strlen(path) < maxlen) {
> -		strcpy(buf, path);
> -		return 0;
> -	}
> -	return -1;
> -}
> -
>  static int open_cgroup(const char *name)
>  {
>  	char path[PATH_MAX + 1];
> @@ -79,7 +20,7 @@ static int open_cgroup(const char *name)
>  	int fd;
>  
>  
> -	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
> +	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))

nice, but could you please follow fs API names and change the
name to cgroupfs__mountpoint

I think we don't need to define the rest of the functions now,
if they are not used

	#define FS(name)                                \
		const char *name##__mountpoint(void);   \
		const char *name##__mount(void);        \
		bool name##__configured(void);          \

just follow the function name

thanks,
jirka

>  		return -1;
>  
>  	scnprintf(path, PATH_MAX, "%s/%s", mnt, name);
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
