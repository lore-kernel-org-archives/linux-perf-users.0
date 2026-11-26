Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795717785;
	b=pdNrPUiCGFh42kJJ1kRf31bg2nZcMmaZ+4Vu3fyMLnnNQr+1aG4cJZfw2/qme0fISl5Q
	 8T479fZRsRpDNCb9z+0WOtZqBNQN9NjGqEDwU4tliN43XDL6IP9d9u9920ROx+gM+B0qO
	 bJzz9/EoHFMe+wITB05JTPSO7s9ZZ3V9xO61aLh/rdtu7Rz6DfIayzLx387dGMuGlm7xr
	 tLRJx+h7h3oiLa7K0oE9jAwGSZm1ORQLZ2N0xbEHLZ65wSGY1HcTjq/uH34Nv7ovUNzOG
	 Y3dU7+RFFZNxiKaM5+RR+6ItTHjNkjYvmo0cnbawsLXZ9UUrKabM3Uqr7J6+1IBQslg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=jQrziGWAtB1RIEv+Kll114OCtYDogfBv1KaAhc31nK4=;
	b=dOy9vjzzD4HuVJuJ5Fd9gVqT2/03R6N5y1+oQgtmQpwh6d0iJe+S01rx8TDAbK2BlhKh
	 gF6tTKE0c0w+e9A3JxjTpww340uUXPERQpw0odqZtYmlNi0T3hb9dCOI68eLaOHSWPpdG
	 nkjac490lzNprRBDD3GrHmwbQ9QJDPXZZhvzOC+HHaits7kmvUuanJNq6GMkAU7ndsv8z
	 ELvc3vXjzGhAuUrW3ZTpy8g9oqxRiPknBxa086dfrIGpARn6bsVESBCi7HTYzTUazc4py
	 mJkko0koerrJq+N82o9Q5b8Wj73HJDRiX6G8KGQGmxc8mXKq+yxkGjiu7qiTMV+fOeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJ4k8yGD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488AA606A321
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 18:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 488AA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJ4k8yGD
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67db3a48dc6so8738434d50.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 10:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795717784; cv=none;
        d=google.com; s=arc-20260327;
        b=p/Y7MpO6zknoLKfHWxYSS9t19QTeHnoEubPlEX1hnYauQwr/9h4UdfnDONszkJZU0C
         eHZw7546qISC9WcLrpfNh31JgpTNe3k0UJSCXGmqiItmZduOh5HLOktKcm1K8YgWiUab
         zzwOwDXixq5lLVoAnY+Hd5YXOX95O/xsyzsH1/fm7n+5xP7+HWzr0I7g5tEhWvqzdf5U
         9Lc3MpGP5avqUtSMGg7k/CZqCQUqQ3Drc3ZKO/X/49giycFbqct9WeiiJdocTAYXXzqK
         oDf4388lpLTbzMwROmCgviXuXbhLI0ST9ejKe2l4ms1yIYTVDnKag7gOv2zW+3jdt4Ye
         PLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jQrziGWAtB1RIEv+Kll114OCtYDogfBv1KaAhc31nK4=;
        fh=7fAJAtfXIpocMNLMRRkcfXrWwGY0wM/KbZLhdGM4axc=;
        b=IMBRwYm03sxKUSNjlgwCwPz9oqdBbEtwtKFEE5JZoksDi/ynPH0ylbORFPYFM6C9G5
         5Ew9itaQxxN2oLB4QqPZIsotdoHOHafjbm0vE2Sgtgy6qmqfivuLYGErTuxb8Jy0P8qR
         LjcZblllm9eTNw7k9WCzuVWpNawofv2L8yRmrL5VLCBdRfd9lfVR7fbK8ZnSBPvXkCAC
         z2Ukc79ZHsthdBAG5jrxyudaLSH1NEjNp2Vwbxbr/fhSw6erGY95zOgQC6pUrzsctKUF
         VY8eDQJo6OhOouu+SasT6cLsYUYKC0wI2P0D2uyn9JcMHdthdt1xDSls1FNnEE9l3Yvj
         mTjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795717784; x=1796322584; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQrziGWAtB1RIEv+Kll114OCtYDogfBv1KaAhc31nK4=;
        b=MJ4k8yGDxGzVLtMMOUe/mfQbMrHzNuoGQG2qy4lERWypTHxAZz7bBXaUgDRdws89qL
         OvJjWJjs7yKZkDjLoc0J2MDSRVp2hmxl5/nyCXIAtJEg+NpWQvJv9IV7D2V9XL96+GYa
         kzUgFyqK33+zcNcePU8wE1ldNzg0le2XnLNkfT3JquXQBMZFED0AK4nHgpMHLBKbX2HA
         EB5QyKNfp846LM9nMXSKtNz6n2KunpWGVQRiVJ74ng+FyIYvm9ko024J8bonudJicvCP
         81A8MSJ3XQ25RhPgVK/AR76pgdmKprD6ouGk3JIYYCW8WaFB/XCOxxa6nJ668dJAmvDg
         JLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795717784; x=1796322584;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jQrziGWAtB1RIEv+Kll114OCtYDogfBv1KaAhc31nK4=;
        b=MDtOrI69h/QtfwgCrPzGgj/iIcdFTnmDKYkKP7i2avs1mr08UpRt6TD2e5q8SgY/4i
         A1ktVOMMLhwWPTgQrI2ymYK7GfyU6qya7X8li9qA7vV6+rAu5QA//065ZMC9ADCBVBOu
         MRVheZotR+h9h0aptX+yNESc6zEj12PmCB1IT/tfpusTGUTcGZsDG0tZ8eFgPglBbm/M
         R/c9OJ/PkX4WF4ytrcAAI5k/tyLmoVPF+0hN/ckACwO7FziWJ8x2ODJciEy7kZZ18Zep
         uypsVjlCyAeuTSK8AOYoILyCJLojQiKrSWAZbaE1qsXGSSacbqQHEeSnIx5LC/QdZSoi
         eZRg==
X-Gm-Message-State: APuU4Z/8E9fzOMf11WJAXmy0vJ3meqU3qRATCTxLd97gAYPXdhN7I13b
	AEnNr6hlhLp+skPlq9E/sxpU9pNa2yS2zJ7jbrd5bMMMlPpW8/Qx3mCrmxlqbG1GUc+woF4JbWN
	6/jp3yGCllVg4h41BI6sr2hD12UlFNyA=
X-Gm-Gg: AZFdTZf3huatLTlHEv53i+NMvgSTntoHelAfDxKwP2SoI+Dye6wahhZ3gDHk/+nZ9MK
	jfbF+5CglaFan7qIsquXiTunzvkSI84Oqs0jKOei/yB77Yq9p/ZvQUBIy//rQD5vtLD8kn+xuJe
	jMidl8yl9aTmSokAedBszGk+BZBRguvnse3vw/bK6d8Cr++Xmhl7R1CSTJWx5nh7rCtHYc0i21K
	nOXbzLLQW2G6cn3ZSofUXCVy3pSLx/ZMdA8f7jfL5yO+UgLiLDKcIhoMJmuxHmsKqWgcxo+3bnQ
	oMT2d9BJ+9JUkg9k8IW2VnG8HpzHk+h8x1BRrz31bc1zbZDfJrIdgEDiuNm4tMWk5WtLfVkq8KU
	E8vXew8aeTHeGb4vV6rXSIwOFytBsYetpz45392QygDTP2B2rEsOGFF+/2fM=
X-Received: by 2002:a05:690e:190a:b0:67c:1b55:8b28 with SMTP id
 956f58d0204a3-67df441503fmr8107822d50.56.1795717784170; Thu, 26 Nov 2026
 10:29:44 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAL57YxZDQFH4cuv+dRbWwN5rv9K-45XbaznSQTQd9xBZLP9Dew@mail.gmail.com>
In-Reply-To: <CAL57YxZDQFH4cuv+dRbWwN5rv9K-45XbaznSQTQd9xBZLP9Dew@mail.gmail.com>
From: Tabby <nyanpasu256@gmail.com>
Date: Thu, 26 Nov 2026 10:29:32 -0800
X-Gm-Features: Aa3M54pKAPB-9zE_8Hy8qWxuUulTRImDGR5BuveBaYBrSjzO9wztKHtrRSFHXAw
Message-ID: <CAL57YxZ5eVuKC6u0uRN96vx7Hr6Pa+2HgE2mLoj4H087ARoOEQ@mail.gmail.com>
Subject: Fwd: Inaccurate unwinding/symbol resolution in `perf report/script`?
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

While using perf for userspace time-based profiling
(speedscope/Firefox Profiler stack charts), I noticed an issue where
`perf record -g` traces have incorrectly reconstructed stack traces
when I run `perf script` and import the profiling trace into a
time-axis viewer.

For instance, when I run `perf record -e sched:sched_switch -e
cycles/freq=99/ -g htop`, I get extra and missing stack frames when
viewing the trace with `perf script` or `perf report`. Interestingly
the perf.data file *does* have enough information to reconstruct
proper call stacks, and `samply import` performs this but `perf
report/script` does not.

## Debugging

I initially suspected that perf failed to query all necessary debug
info. Running `DEBUGINFOD_VERBOSE=1 perf script` shows that perf is
querying debuginfod for every build ID found in `perf buildid-list`,
but still outputs inaccurate frames from `-g/--call-graph fp` stacks.
I do not know if perf can't find downloaded debug info, can't find
on-disk binaries, or has an algorithmic deficiency.

I took a look at the call stack captured by `sched:sched_switch`,
where htop blocks on user input within wgetch.

- `perf script` reports the blocking call stack as `_start >
__libc_start_main > call_init > unknown > CommandLine_run >
Platform_done > LibSensors_cleanup > ScreenManager_run > wgetch >
[unknown] > __poll > syscall_cancel > internal_syscall_cancel.` This
has both missing and incorrect stack frames; notably in the source
code, `CommandLine_run()` directly calls `ScreenManager_run()` without
the intermediate frames.

-  If I run `perf report` and view the call chain from `_start`, it
reports the extraneous stack frames as `Platform_done (inlined)` and
`LibSensors_cleanup (inlined)`. Expanding further, it reports that
`wgetch` calls an unbranched chain of `0x7ffb69c4ada2 > __poll >
syscall_cancel (inlined) > internal_syscall_cancel (inlined)`. Here it
fails to resolve wgetch's function calls (whereas gdb and `layout src`
reports that wgetch calls _nc_wgetch > check_mouse_activity >
_nc_timed_wait > poll`.

- If I run `samply import perf.data` on the same capture, and load the
trace in Firefox Profiler, I see `start > _libc_start_main_impl >
_libc_start_call_main > CommandLine_run > ScreenManager_run > wgetch >
nc_wgetch > check_mouse_activity > _GI___poll > syscall_cancel >
internal_syscall_cancel`. This shows that `samply import` and the
Firefox Profiler it spawns knows to omit the false frames between
CommandLine_run and ScreenManager_run, and properly resolves the
frames between wgetch and ...poll... This call stack is also
comparable to what gdb reports.

- - Unfortunately samply is not a full replacement as-is, because it
only includes the first `-e` (I've reported to Samply and not heard
back yet) and doesn't symbolize in-kernel stack frames.

Is there an explanation or possible solution for this issue?

Kernel: 7.3.5-arch1-1 (64-bit)

## Prior art

It does seem that perf unwinding is a subject in flux.
https://lore.kernel.org/linux-perf-users/CAP-5=fWkUW787c4dGx9rccucqD67dfRgwBB_SoCxFnfZXtXP-w@mail.gmail.com/T/#t
indicates that in-kernel DWARF unwinding is being proposed, but it
presumably will not be ready for some months.
