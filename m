Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2515ACA;
	Thu, 22 Aug 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349207; cv=none; b=VsKWPFXKek5dDujrFRKYKu+dra5Gy4TQGjbVyfoXCtf9uckne10ivlzxIgX+HbCBN7lNk0Wm7ES7DsdN/K6PRaKSYN4bgtos5dbBlNiIm6nc9DLWerWm6O9dET44nlFYXTTH3QUmQBS0vef24FSbMa/U0mPJjwZgOYyRhyPBjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349207; c=relaxed/simple;
	bh=sAFNnCxNozI9ONBhH+atNGZbzjHIHFoFBHVXDPPWdII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM3Z/UbpvcqNjiUD6v9iaWIlBwTn5NyNFV0Q/qw/bD7Vi+i5i+LT4QHl8VeBAmLxQd5AlCmfNSKjG90ui0mNnHsIEI/0E+dZnrO67hKgEGYM2qTA4ANdM6PnGySeZ5z0ujUdoMiOaWaHMd9heBmkJD6abN+ibGNe38t0kkijsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AojK2w5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AojK2w5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871DFC32782;
	Thu, 22 Aug 2024 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724349206;
	bh=sAFNnCxNozI9ONBhH+atNGZbzjHIHFoFBHVXDPPWdII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AojK2w5Cc961FYfcg4CYVJ+lF8RU7AW27M+J4r9kRberaKBXVAPT3jjw8JqmkMHlk
	 twSK5gOhRQ5WYmQQ2ufcdt5nka/2gTsNfEgG4PVXaqIDOFDsfC5PL4Q5qwn/TK0byy
	 2onRNN7vano8dvtCzSSf5Y+2MNjNbW3BGvZ3tX5H8gs0QfKQKrwp7gYCxcCtEaMv6C
	 5BQ9/kOCMntNGp3ptSgu/1B19vauo4zBvGt4Af0TvW6rL0C3uGv4Sc1aq6c02KcVmI
	 hv2MhHKFdnsWbgnqPB9lJt8XTZP3YLH8Fapgmhu35Dn4ERJ0qiIZNu0N7RC759qeh0
	 6SAHWsVkHjqww==
Date: Thu, 22 Aug 2024 14:53:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] perf trace: Add
 trace__bpf_sys_enter_beauty_map() to prepare for fetching data in BPF
Message-ID: <Zsd7Ep6H24Qq-h5F@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-4-howardchu95@gmail.com>
 <Zsd6MgrCs0ybQ9EW@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zsd6MgrCs0ybQ9EW@x1>

On Thu, Aug 22, 2024 at 02:49:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 15, 2024 at 09:36:19AM +0800, Howard Chu wrote:
> > @@ -3624,7 +3719,9 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
> >  {
> >  	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
> >  	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
> > +	int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
 
> At this point we still don't have that, right? I.e. building with this
> patch, without the ones following it in your series, I get:
 
> builtin-trace.c: In function ‘trace__init_syscalls_bpf_prog_array_maps’:
> builtin-trace.c:3723:58: error: ‘struct <anonymous>’ has no member named ‘beauty_map_enter’
>  3723 |         int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
>       |                                                          ^
>   CC      /tmp/build/perf-tools-next/tests/code-reading.o
>   CC      /tmp/build/perf-tools-next/trace/beauty/clone.o
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/build/perf-tools-next/builtin-trace.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> 
> So we need to squash the patch that introduces beauty_map_enter in the
> augmented_raw_syscalls.bpf.c file to this one, so that we keep things
> bisectable, I'll try to do that.

So just this did the trick, I'll remove it from the later patch in your
series:

- Arnaldo

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 0acbd74e8c760956..c885673f416dff39 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -79,6 +79,13 @@ struct pids_filtered {
 	__uint(max_entries, 64);
 } pids_filtered SEC(".maps");
 
+struct beauty_map_enter {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, __u32[6]);
+	__uint(max_entries, 512);
+} beauty_map_enter SEC(".maps");
+
 /*
  * Desired design of maximum size and alignment (see RFC2553)
  */
