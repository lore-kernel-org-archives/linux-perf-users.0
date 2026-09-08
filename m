Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C43DC4C9
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901032; cv=pass; b=VE2mTM/vzs9Zvd+UjYY/QGdR8AYp91KqK37D/sDlF1KclXakgRmhHlNVy8n5cS6CBVish/0aqtWI+pf3HsDw5DuJPxtiYrjsVQKsNpMjPnb/PSBRkLzEwFAf0DKX8kkgqCdbpnVMb4hCxD7ud2xx+MLTEepNVVGinSumT1ZAVUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901032; c=relaxed/simple;
	bh=eVo2ETLGu/64oGaNGV8KvVJmKGSFz6e4Q/WvJ0CP1J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piqgZW0ClG3jt+htcNhij2NOoH+Qz2BrFfsSz3PjkvdpgQbYgvOhxzg9oO5s2fSfYLeeU55dmrlqtcnxadoZVNR2BvDwAz6gP3USTIdJ1bW+oXBFIWF2Kdgt2G9ujTtRxcnaVdZXxWgkzTCYxedOGVWK9LGDE93iqIvGcosCV0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1F4fRjr; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1F4fRjr"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso3001cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 13:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788901029; cv=none;
        d=google.com; s=arc-20260327;
        b=RkE7x3gSLWhZuD/1g35po0kaKAHfHL0dri8hcMfdCx/RgnXEtzDAeOV/g6oWjAUt5S
         M62mZ61K864k4yGEdLgj6RLLp7Xtl8NGPzL78n9DDc9p7abnXa3LtCn7e3x7yBQqqIPr
         y0FFTs8kYm0JU2+zmT1seioPFZ4X6s2N3IniTHiaKJS+t8DyFrzstDmZiMW/DoPTFyhQ
         J455jogGWhEv79oXKf/cGLxiJcU0QlSbcZSN/48Nslfzw+qGP0U5HFnu+HSV5dLqjQOz
         ly8UHIdWhXcugBGFxpMGW5+RDLxxUe6VvgYZvZW0ICw1tFSA5asVLqJPadwuNCXQkk4H
         NHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVo2ETLGu/64oGaNGV8KvVJmKGSFz6e4Q/WvJ0CP1J8=;
        fh=t+lWWfkqUbNylNumtKNev+zFNFYK7z4SniA5ZtuIq8k=;
        b=gBkGlxaLnm/dyaRnn/uFxheUIrc0ZP7sBYa/qsMUJO1GKyIdz+5JK0cXw9Mfxl6DA6
         uVXhXMf+Y/jrJ7DjUQXzGqJZQDa9beuDaF39U8creF3Hye4IUltCK4Ni0l3+2Q1fvoAA
         jkPyi25DlwcKGv9W585crfX0cHbztpPkwSV4r0+4UHX8F3HWL93bXp6e9CPF7Pppw1Z8
         sUlOTqeqOJiwPdc5W6pk+rFyCNf/oZ2hHPNkjAmftHC39DJixMEBdsw3nuMLaE34CoHr
         7tysh2Larpw5y6okTIIxX5130+fxIZe5eOOXe6z/g9uB2cEFNrcgd2rRYzIf1ZEzY0kY
         DfZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788901029; x=1789505829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVo2ETLGu/64oGaNGV8KvVJmKGSFz6e4Q/WvJ0CP1J8=;
        b=L1F4fRjrJxwtwD1Zhuyi0DSi/eYeL7OgGf2ribUo/kJKOn4+emDH2/CtiaqKreR3AV
         agT/7fZ1F5O9cuYRLV5yHLwtZOJA+pEHm6UqI4YZVdUi/sALaBX2wW9R7rfFMzgMKRNS
         xdxjBXtNq83QmpAl18fQayFjUDM3Ns3CpAU+dY0sa1IboNvOvIjGMbZMVoqKXEFCRxbV
         FoJNIK4fLIElHMno6mp7rzAsYg0WlNUpZvUNA3D5OKLoKPOJ6QMdy6a5PiBlDxbhwzW2
         +YVoQLJKQRtsh0k450F6lVvP25wPATGHe2LEuWsVeSmsd2q0ZeWpsGINbVaHYVBCxvFW
         bYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901029; x=1789505829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVo2ETLGu/64oGaNGV8KvVJmKGSFz6e4Q/WvJ0CP1J8=;
        b=OP9WBAgW6KlMerdHOEm/uHkyj74GuCIeScOStzE9EWt5SP10FzJ2BYQQQlpjgk9j4n
         sR/DIeI7Op8g+LVB6Xh1vz+LpSl/winDgsr/oRECof9A1FlsASyiLkPOaZVks54sF5Kd
         x5u37lcE3JaNF/1j/8tkSTJXI7qsoN6cD1RAZc/SegffSL9nECq51cLRm+Fuvggi6Qjh
         4cm87vj0EIt61ucY+N2TuqirRRuQ6XNBwN4CB3vo9tVUaEnPooNbF8uRi8pPQMYTFr4d
         OQoTlR2o8SVkztv5IMcSTJNiQf7P6++CSFE8rldsfOEKjhELUxg9ED0aobNsb7IdRT1v
         lOPw==
X-Forwarded-Encrypted: i=1; AKwUvBywHbWrpWGxqs+4kCD1w5mFYmDR05CNH5gKtRuEBSfleISVY40sFaceG2UCDa7qqvFes85D+fZnkHoxpMr2wtVg@vger.kernel.org
X-Gm-Message-State: AFuF++nWERryEeZkBEiMxKc3diwDxCHzzPb+ZoKD7y4oD+Bxnjb35RJl
	CHxVZcDANeTf7D9J+M2viUo2M+ses/sbkhxJd3lIjP68GxcNXJzMcdjqXHM2d8hwJhJn/Irj9wN
	sTIWMdthtmdfvSh5eoB1Xo57PdCAGlzni5DHZ8Vus
X-Gm-Gg: AYBFou1WKlyvKPTG7Zm1lQPqKpbvL59z9+H7Rou4iDYVBpXUk40XeBfGErls9Xlq1lv
	X4C5vboSHzszFCMIIOhOUnox0csr65eJzsSMPlCnDmkJbcB4OhE90S7d4EHXdPyU1Ip8fZ/NuIZ
	BTTHR/t3Z60BEf7DUUJkGpeTGyVHSpLsFYKkdebiDh3vbzLHX8vwB1B8CaOYXbx2xed7FUpyF1S
	9HY7Rk/FYSMu8ZlmGeJopFCPB7jqiJ8nxMY8IfiKFC/ZZy2YwAP/aO7jCif7V9Zbm7ko+wrdIQq
	hkq83p7UVrcK47RByPTIHlAtL98ao0M+rbvagl6G1M5te4M5CJklG27nO3X0lJqiliFjozRsqA=
	=
X-Received: by 2002:ac8:5d48:0:b0:530:4cc8:b0b8 with SMTP id
 d75a77b69052e-530a46fdc0dmr3720261cf.0.1788901028687; Tue, 08 Sep 2026
 13:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com> <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
 <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com> <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
 <aqAlddsFPYJvRhFr@tassilo>
In-Reply-To: <aqAlddsFPYJvRhFr@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Sep 2026 13:56:56 -0700
X-Gm-Features: AcwNN1X966ABp7yeo8WK-GTAn53V_0RKsGXVzyPRdBek6tFMdJkXdAygR0j64J8
Message-ID: <CAP-5=fWbSNYpt8p3e+pqjY+xhqs8WrzsBfPaKB1NLBm88mH8Yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for PERF_SAMPLE_STACK_USER
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Eranian Stephane <eranian@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>, 
	Gennady Kupava <gennady.kupava@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 8:10=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> > That's what we already do, no? I have distinct memories of making the
> > stack unwind use the NMI regs rather then the PEBS regs.
> >
> > > In my opinion, it could even make the thing worse. User
> > > requires to get precise samplings, but perf silently returns imprecis=
e
> > > records, this would mislead user.
> >
> > Mostly just the unwind might be off a little, the rest is accurate. Thi=
s
> > has been the case 'forever'. Performance analysis isn't for silly
> > people, if they can't deal with a little fuzz then perhaps they're in
> > the wrong business.
>
> Is the main problem that the stack doesn't agree? Perhaps there
> could be a check for regs->rsp =3D=3D pebs->user rsp (if in user space)
> to detect problematic samples.
>
> The question is how to report it and who should do the checking.
>
> It may need new fields in the ABI either to communicate the extra PEBS RS=
P
> or a bit to indicate that there might be a mismatch.
>
> I guess checking in the kernel and reporting an error might be simpler
> and maybe cleaner, but it would likely limit more advanced recovery
> possibilities.
>
> Are there other mismatches that break the unwinding? Perhaps the same
> for RBP?

For DWARF unwinding any register may be the source of a frame pointer
(e.g. the OpenSSL library would use R11 rather than RBP).

There is redundancy on x86 you can sample the PERF_REG_X86_IP register
in the user register and there is PERF_SAMPLE_IP in the sample event
itself.

My understanding is that IBS can only sample IP and so for precise
samples we can use PERF_SAMPLE_IP as the precise location and the user
register PERF_REG_X86_IP as the interrupt IP - this would match the
other register values in the interrupt.

In DWARF unwinding, we initialize the register state using the sampled
user registers:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/unwind-libdw.c?h=3Dperf-tools-next#n270
and on x86 we sample all registers for DWARF unwinding:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/x86/include/perf_regs.h?h=3Dperf-tools-next#n20
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/perf-regs-arch/perf_regs_x86.c?h=3Dperf-tools-next#n=
238

Having PERF_SAMPLE_IP be precise and the user registers from the
interrupt I believe works for AMD IBS and ARM SPE, but for Intel PEBS
there is the ability to use the PEBS register samples for other
non-redundant registers. In the x86 driver could we disable PEBS
sampling for these registers when doing user stack sampling, so that
the sampled user registers match the stack sample? We can keep the
PERF_SAMPLE_IP precise, and make all the registers precise when there
is no stack sampling.

Thanks,
Ian
