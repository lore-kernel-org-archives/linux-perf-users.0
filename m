Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362EF1758F;
	Mon,  9 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899601; cv=none; b=W0qjLjlbI3sRyldPLaN+QXkBKecLF+M+UdGj3Crt06pc3De3909AI0Ro4HCveXhTr2xmzIDCe5cIc1Wf+OZsqmKH5yhfSXTDhzeYYpNMOCpQpzLpzvhpNQv4OVXRdppMbDaHSozKs+uJ8yEqQW2Pbr1LLm1HkHbHbvjfW9MXVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899601; c=relaxed/simple;
	bh=9ADpIw6RxMCzXJM3i+IHKdReWXkmBWSBvzb5YR35yOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClrKBNJUT+DhyDrrVnGAC2IK3Qf4PfAgrqOjVlo8fmAZTacvffUkDkhJS7ZtOiCPn6WVHvpwsU1rYOO178s9fN0U3l+BFKVFGpzYCyy/1mFD/1B0+7uJ7uhaypT6jdp4r7vJjmQw3TTsk4F2fSvaQOKGKSz9H3QfIDFj8ChamKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGUvtzYL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGUvtzYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6269AC4CEC5;
	Mon,  9 Sep 2024 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725899600;
	bh=9ADpIw6RxMCzXJM3i+IHKdReWXkmBWSBvzb5YR35yOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGUvtzYLjH+vawSouE8nPwb74khn+JKdaBXGltYTRJZH0T0ENEticcjZNbgChIhJ8
	 WCqpb/z9HcXrFMhaGzc0GB1wD5XztHPux0kyiUWEuXg41J8l1ZnYHh/zLbFWb+2sNx
	 SvAn0ttA9g9YDHhkYqjp02QGcBREOeQsMfvr9G70TFM2Tm+aAuKiZJaPXFj8eqtndX
	 QbJXc2g5ATxkAuqlLoUkT5trBdlKZb0NRNXgJw9Mg/Ut8Gn+GRIAxkbu56f/tXfek7
	 Ra/TuP7SwULWSzizLqRX1g8n+uatTP3lE3XknqyD97b1GUBip3gZm6dkTwp+MrNOCh
	 ADnmF7SLWbFPg==
Date: Mon, 9 Sep 2024 13:33:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 5/8] perf trace: Pretty print buffer data
Message-ID: <Zt8jTfzDYgBPvFCd@x1>
References: <20240824163322.60796-1-howardchu95@gmail.com>
 <20240824163322.60796-6-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824163322.60796-6-howardchu95@gmail.com>

On Sun, Aug 25, 2024 at 12:33:19AM +0800, Howard Chu wrote:
> Define TRACE_AUG_MAX_BUF in trace_augment.h data, which is the maximum
> buffer size we can augment. BPF will include this header too.
> 
> Print buffer in a way that's different than just printing a string, we
> print all the control characters in \digits (such as \0 for null, and
> \10 for newline, LF).
> 
> For character that has a bigger value than 127, we print the digits
> instead of the character itself as well.
> 
> Committer notes:
> 
> Simplified the buffer scnprintf to avoid using multiple buffers as
> discussed in the patch review thread.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/r/20240815013626.935097-8-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-trace.c      | 33 +++++++++++++++++++++++++++++++++
>  tools/perf/util/trace_augment.h |  6 ++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 tools/perf/util/trace_augment.h
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 048bcb92624c..470d74e3f875 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -65,6 +65,7 @@
>  #include "syscalltbl.h"
>  #include "rb_resort.h"
>  #include "../perf.h"
> +#include "trace_augment.h"
>  
>  #include <errno.h>
>  #include <inttypes.h>
> @@ -852,6 +853,10 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
>  
>  #define SCA_FILENAME syscall_arg__scnprintf_filename
>  
> +static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg);
> +
> +#define SCA_BUF syscall_arg__scnprintf_buf
> +
>  static size_t syscall_arg__scnprintf_pipe_flags(char *bf, size_t size,
>  						struct syscall_arg *arg)
>  {
> @@ -1745,6 +1750,32 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
>  	return 0;
>  }
>  
> +#define MAX_CONTROL_CHAR 31
> +#define MAX_ASCII 127
> +
> +static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg)
> +{
> +	struct augmented_arg *augmented_arg = arg->augmented.args;
> +	unsigned char *orig = (unsigned char *)augmented_arg->value;
> +	size_t printed = 0;
> +	int consumed;
> +
> +	if (augmented_arg == NULL)
> +		return 0;
> +
> +	for (int j = 0; j < augmented_arg->size; ++j) {
> +		bool control_char = orig[j] <= MAX_CONTROL_CHAR || orig[j] >= MAX_ASCII;
> +		/* print control characters (0~31 and 127), and non-ascii characters in \(digits) */
> +		printed += scnprintf(bf + printed, size - printed, control_char ? "\\%d" : "%c", (int)orig[j]);
> +	}
> +
> +	consumed = sizeof(*augmented_arg) + augmented_arg->size;
> +	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
> +	arg->augmented.size -= consumed;
> +
> +	return printed;
> +}
> +
>  static bool trace__filter_duration(struct trace *trace, double t)
>  {
>  	return t < (trace->duration_filter * NSEC_PER_MSEC);
> @@ -1956,6 +1987,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
>  		     strstr(field->name, "path") != NULL))
>  			arg->scnprintf = SCA_FILENAME;
> +		else if (strstr(field->type, "char *") && strstr(field->name, "buf"))
> +			arg->scnprintf = SCA_BUF;

You can't really do this for things like 'read' as we would be printing
whatever is in the buffer when we enter the syscall, right? As we can
see testing after applying the following patch:

root@number:~# perf trace -e read,write cat /etc/passwd > /dev/null
     0.000 ( 0.004 ms): cat/291442 read(fd: 3, buf: \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0, count: 832) = 832
     0.231 ( 0.004 ms): cat/291442 read(fd: 3, buf: , count: 131072)                                     = 3224
     0.236 ( 0.001 ms): cat/291442 write(fd: 1, buf: root:x:0:0:Super User:/root:/bin, count: 3224)      = 3224
     0.239 ( 0.001 ms): cat/291442 read(fd: 3, buf: root:x:0:0:Super User:/root:/bin, count: 131072)     = 0
root@number:~#

So we can't really do it at this point, we have to do it, for now, by
doing it on that syscall table initialization, for instance, for the
'write' syscall:

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5f0877e891c2047d..1bcb45e737d830bf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1379,6 +1379,8 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [2] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
 	{ .name	    = "waitid",	    .errpid = true,
 	  .arg = { [3] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
+	{ .name	    = "write",	    .errpid = true,
+	  .arg = { [1] = { .scnprintf = SCA_BUF, /* buf */ }, }, },
 };
 
 static int syscall_fmt__cmp(const void *name, const void *fmtp)
@@ -1987,8 +1989,6 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
 		     strstr(field->name, "path") != NULL))
 			arg->scnprintf = SCA_FILENAME;
-		else if (strstr(field->type, "char *") && strstr(field->name, "buf"))
-			arg->scnprintf = SCA_BUF;
 		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
 			arg->scnprintf = SCA_PTR;
 		else if (strcmp(field->type, "pid_t") == 0)

With that we get:

root@number:~# perf trace -e read,write cat /etc/passwd > /dev/null
     0.000 ( 0.005 ms): cat/296870 read(fd: 3, buf: 0x7ffe9cb8df98, count: 832)                          = 832
     0.268 ( 0.004 ms): cat/296870 read(fd: 3, buf: 0x7fa7d700a000, count: 131072)                       = 3224
     0.273 ( 0.002 ms): cat/296870 write(fd: 1, buf: root:x:0:0:Super User:/root:/bin, count: 3224)      = 
     0.276 ( 0.001 ms): cat/296870 read(fd: 3, buf: 0x7fa7d700a000, count: 131072)                       = 0
root@number:~#

After the following patch is applied.

- Arnaldo
