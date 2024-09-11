Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B87E583;
	Wed, 11 Sep 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086318; cv=none; b=PlWzVIWAc5nmt5ka3qQZotAXZJ2ZG2YUfl1rkdo8h/qbGUo2TaVpVoW7SbnWGi0Mn8vLGR1Jfq8PG68r3BS7hT3kcrOqBHJ7V0vMMOHmFIPjI4ZwWgnOwedoH/agf09Xvd1BmVX/GRgus50V5gq7/Rj2wzs1BNgB9W6uRaCcXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086318; c=relaxed/simple;
	bh=IJJdXeHVHtKkohEPXFg2xqIXxTb1Yt13CSpv4cNNAVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uv7T2SzibHww9QralFhI2W+qorBckcO0jhrp7iT3VBubvu+hs4K9Pe/Nyxv2zOJFM7NzSW0yx4TgpBvapeHWhomb93X9gf9g04n5VJ0FAirK6A0AgidEbbbyaoKP3/tL11FrFYnGvSknE5HcVPazhREaPz4NNs1LOvSbynhKMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohOFs31Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohOFs31Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85685C4CEC0;
	Wed, 11 Sep 2024 20:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726086318;
	bh=IJJdXeHVHtKkohEPXFg2xqIXxTb1Yt13CSpv4cNNAVI=;
	h=Date:From:To:Cc:Subject:From;
	b=ohOFs31ZjQq48m4Vi/IkZVgxBj0LFoYK8RYg+/do3hbfaL8eK218J4dOBSw4r7rfu
	 SVsbXdHQdde1JuwyQsGUCBs6bAqjVEQko9KAVDGX9rp0TnzIOwJVZ8L4RTapZCZIGA
	 WY2sSzf/Wq9plgkQUuATIoUnPDjpZBtRiX2Yc4TlFpOSE4rxrxtx+wIFtrwd9GClpG
	 uv3f8a/3M66IqdUcTM2QgdLeuG/d8wPKiadws+labpS1cpduOqkqNmO2GTAJi6RwlB
	 1U8kDkxuV79PlrXK7cwl5N/wDZn9nVMpa/Qy0LsS/2Byikq/ZDur7Fvb8T+F0nK//I
	 TVseNudot497Q==
Date: Wed, 11 Sep 2024 17:25:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: perf trace: substruct BTF based pretty printing
Message-ID: <ZuH8qhuZB6mr9JvR@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Howard,

	Not really a requirement on you to do work, just a some notes to
add to our discussion/experiment on using BTF to pretty print syscall
(and tracepoints/whatever) arguments:

root@number:~# perf trace -e setitimer -p 5444 |& head -5
     0.000 ( 0.017 ms): Xwayland/5444 setitimer(value: (struct __kernel_old_itimerval){})                   = 0
     0.050 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel_old_itimerval){})                   = 0
     0.142 ( 0.005 ms): Xwayland/5444 setitimer(value: (struct __kernel_old_itimerval){})                   = 0
     0.174 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel_old_itimerval){})                   = 0
     0.293 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel_old_itimerval){})                   = 0
root@number:~# strace -e setitimer -p 5444 |& head -5
strace: Process 5444 attached
setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=5000}, it_value={tv_sec=0, tv_usec=5000}}, NULL) = 0
setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=0, tv_usec=0}}, NULL) = 0
setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=5000}, it_value={tv_sec=0, tv_usec=5000}}, NULL) = 0
setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=0, tv_usec=0}}, NULL) = 0
root@number:~# 
root@number:~# 
root@number:~# grep -w value /sys/kernel/tracing/events/syscalls/sys_enter_rseq/format 
root@number:~# grep -w value /sys/kernel/tracing/events/syscalls/sys_enter_setitimer/format 
	field:struct __kernel_old_itimerval * value;	offset:24;	size:8;	signed:0;
print fmt: "which: 0x%08lx, value: 0x%08lx, ovalue: 0x%08lx", ((unsigned long)(REC->which)), ((unsigned long)(REC->value)), ((unsigned long)(REC->ovalue))
root@number:~# pahole __kernel_old_itimerval
struct __kernel_old_itimerval {
	struct __kernel_old_timeval it_interval;         /*     0    16 */
	struct __kernel_old_timeval it_value;            /*    16    16 */

	/* size: 32, cachelines: 1, members: 2 */
	/* last cacheline: 32 bytes */
};

root@number:~# pahole -E __kernel_old_itimerval
struct __kernel_old_itimerval {
	struct __kernel_old_timeval {
		/* typedef __kernel_long_t */ long int           tv_sec;                 /*     0     8 */
		/* typedef __kernel_long_t */ long int           tv_usec;                /*     8     8 */
	} it_interval; /*     0    16 */
	struct __kernel_old_timeval {
		/* typedef __kernel_long_t */ long int           tv_sec;                 /*    16     8 */
		/* typedef __kernel_long_t */ long int           tv_usec;                /*    24     8 */
	} it_value; /*    16    16 */

	/* size: 32, cachelines: 1, members: 2 */
	/* last cacheline: 32 bytes */
};

root@number:~#
