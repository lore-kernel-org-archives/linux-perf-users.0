Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7E43DA5B3
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534480; cv=none; b=PSCN/j+UDBKuKSUVYm6rOU7d/tFMxoP3ohulf+jUDhbbTuKnGKIyZtrBcMsVYkl56Dk5ChwIq8sGweC7kkWEqwgxgjV8/QjQVSHCkDjqjHMCQsD2rguVvfm8rdLB4jTQipSXmPaiaNPvj3COvSOdItrWkL4n4pnd+0PoX+9A+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534480; c=relaxed/simple;
	bh=fg0CS3v1uAvE6tnx4anzRrgR/YRoKiKIxHQ7ATwOdas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dRYtpNCKM+bkut+9C2/XIbqcU1ieZDukxyGPPiuRD7ehi23OHpAN+D2Km16QkU492T2G8fSpJjdXLEbUanGVXSRgzyhow1mP83pwv6tVNsCvMPi7pJR0S9823VHeQcicKjHBcskztnZg55QXIupTy8TXJuqsIhJwZEJZl9o3h78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr0I8bHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr0I8bHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6F11F00A3D;
	Fri,  4 Sep 2026 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534476;
	bh=lnS3huVAfKrotAv8D6H/afQ3Js4TDfHck0BI+usDsIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fr0I8bHB/REfz9ALdRWZ+eLgD46tN44J0wWZgOCtANFfGHFBqv+QQ5UtANU3B7V1H
	 JrtEmjzLQicXR6VFtO7j5UVRp7k4cCYC0bhffImFB2kFFb/KG6fZ3i0BzfEjfGJR30
	 M/CXEPSQANPSaR5emKvsWJnyF8XqKHY9uqXzHNlaSxexeqtGdluuNYb1diaFLurKHo
	 WjLv5eq+9CmLVAnVUGqLZpSvZ+PZp9P2gE8HGgc8RHCOxANrkik+RRkFWtF2LYETRh
	 j4ww2TbK6Y1KbGBXyzCNujzntdzM5YI0v+x9gBlY59Wq5K41RfQjbzDTZmiNzwIfCJ
	 /OZbTA0MIwd1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf jitdump: Free unwinding data even when
 eh_frame_hdr_size is zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904144058.3341-4-acme@kernel.org>
References: <20260904144058.3341-1-acme@kernel.org>
 <20260904144058.3341-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:07:55 +0000
Message-Id: <20260904150755.DD6F11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Arbitrary File Overwrite via Predictable JIT ELF Filename (Sym=
link Attack).
- [High] Unwinding and debug data leak to subsequent records on error paths.
- [High] Silent suppression of parsing errors in jit_process_dump() loop.
- [Medium] State leak and MMAP2 length truncation in jit_repipe_code_move().
- [Medium] Ineffective use of flockfile() for inter-process synchronization.
--

commit 9551fc5ddf55f406039867f081e66a51333a4aa8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Free unwinding data even when eh_frame_hdr_size is zero

This patch fixes an issue in jit_repipe_code_load() where unwinding state
was not properly cleared when eh_frame_hdr_size was zero. It updates the
cleanup condition to rely solely on the presence of unwinding_data, ensuring
it is freed correctly and not mistakenly applied to subsequent records.

Looking at jit_emit_elf() in the same file:

tools/perf/util/jitdump.c:jit_emit_elf() {
...
	nsinfo__mountns_enter(jd->nsi, &nsc);
	fd =3D open(filename, O_CREAT|O_TRUNC|O_WRONLY, 0644);
	saved_errno =3D errno;
...
}

[Severity: Critical]
This is a pre-existing issue, but does this open() call enable a symlink
attack?

perf inject --jit reads perf.data to find JIT dump directories, which are
specified by the monitored process and can be in world-writable locations
(e.g., /tmp). It constructs a predictable filename jitted-<pid>-<index>.so
in this directory.

The open() is called with O_CREAT|O_TRUNC|O_WRONLY but without O_NOFOLLOW
or O_EXCL.

Can a local attacker create a symlink at this predictable path pointing to
a critical system file (like /etc/shadow)? If perf inject is run by root
or a privileged user on this untrusted perf.data, would the target file be
truncated and overwritten with ELF data?


Looking at jit_repipe_code_load():

tools/perf/util/jitdump.c:jit_repipe_code_load() {
...
	/* sym string lives between the load header and the code blob */
	if (!memchr(sym, '\0', code - (unsigned long)sym)) {
		pr_warning("jitdump: unterminated symbol name in code_load record\n");
		return -1;
	}
...
}

[Severity: High]
This isn't a bug introduced by this patch, but do jd->unwinding_data and
jd->debug_data leak if the function returns here?

jd->unwinding_data and jd->debug_data are global state pointers holding
dynamically allocated memory for the current JIT record.

If jit_repipe_code_load() hits this error condition, it returns -1
immediately. The allocated memory is not freed, and the size fields are not
reset.

Because jit_process_dump() ignores this error and continues parsing, will
the leaked unwinding and debug data be erroneously applied to the next
successful JIT_CODE_LOAD record, corrupting its ELF sections?


Looking at jit_process_dump():

tools/perf/util/jitdump.c:jit_process_dump() {
...
	while ((jr =3D jit_get_next_entry(jd))) {
		switch(jr->prefix.id) {
...
		default:
			ret =3D 0;
			continue;
		}
	}
	return ret;
}

[Severity: High]
This is a pre-existing issue, but does this loop silently suppress parsing
errors?

The while loop iterates over records and assigns the result of processing
functions to ret. There is no error-checking mechanism (e.g., if (ret)
break;) to halt processing.

If a subsequent record is successfully parsed, ret is overwritten with 0.
If an unknown record type is encountered, the default switch case explicitly
resets ret =3D 0.

Does this cause critical memory allocation failures, invalid record sizes,
or corrupted streams in the middle of a JIT dump to be completely ignored?


> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index e0d5cc9a82818..efb40d93e33ae 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -530,7 +530,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  		jd->nr_debug_entries =3D 0;
>  	}
> =20
> -	if (jd->unwinding_data && jd->eh_frame_hdr_size) {
> +	if (jd->unwinding_data) {
>  		zfree(&jd->unwinding_data);
>  		jd->eh_frame_hdr_size =3D 0;
>  		jd->unwinding_mapped_size =3D 0;

[Severity: Medium]
This is a pre-existing issue, but does modifying jit_repipe_code_load() to
unconditionally clear jd->unwinding_mapped_size cause a state leak and
MMAP2 length truncation in jit_repipe_code_move()?

jit_repipe_code_move() computes the new mapping length by reading the global
jd->unwinding_mapped_size into usize:

tools/perf/util/jitdump.c:jit_repipe_code_move() {
...
	usize =3D jd->unwinding_mapped_size;
...
	event->mmap2.len   =3D usize ? ALIGN_8(jr->move.code_size) + usize
				   : jr->move.code_size;
...
}

Because of the unconditional clear in this patch, unless a JIT agent emits
an out-of-sequence JIT_CODE_UNWINDING_INFO record immediately before the
MOVE record, will usize always be 0?

Does this cause the new MMAP2 record length to incorrectly truncate the
memory mapping, failing to cover the .eh_frame section from the original
JIT allocation?

Furthermore, if an agent does emit an unwinding record before the move,
jit_repipe_code_move() uses the size but fails to clear it. Does this leak
the state to all subsequent MOVE records?

>  		jd->unwinding_size =3D 0;
>  	}


Looking at jit_open():

tools/perf/util/jitdump.c:jit_open() {
...
	/*
	 * protect from writer modifying the file while we are reading it
	 */
	flockfile(jd->in);
...
}

[Severity: Medium]
This isn't a bug introduced by this patch, but is this use of flockfile()
ineffective for inter-process synchronization?

The comment states this is to protect from a writer modifying the file while
reading it. However, the writer is the JVM or JIT agent executing in a
different process.

Since flockfile() is a POSIX thread-synchronization primitive that only
locks the FILE * structure for thread-safe stdio operations within the
same process, it does not acquire an OS-level file lock.

Does this leave the reader vulnerable to data races and parsing corruption
if the dump file is read concurrently while the JIT agent is appending to i=
t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904144058.3341=
-1-acme@kernel.org?part=3D3
