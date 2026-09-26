Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800B2931FF
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790393582; cv=pass; b=Pw+TcK878EQk4L9F7f3e3mE6Er+dMsXe095v31zfVl7SPhWCVWT7AEHdsk77ndsWYzlhXeTdDTSOsrg0fZFioIeVBh8uGp6OSGeo+UtCnFenZfWKscO0TnufBczlj7uLcMGul1mf2VVh9zyYS3EUjVBXrwHJ8gMiz7BO24+zHHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790393582; c=relaxed/simple;
	bh=Mrl9hnYjNzsvW5V/54263E3XvGLPbjPgQW7Qq+pl7+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twhNH3iaVZVexwq4/mCgPmZ2QpqbnGhtOTxIR0yho3yOQVaREt5zvNGgtclW0YGckqU1sqnkqqy7uh62mkD82ARXVl+kznhnQFI49a6F3j9PI8T+dEMlXWbe2BO5dhTJ7DgBGQViddA5lEsWAlkpuQTdR8o1jB3MFcMq3c5BgNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVriEuJI; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVriEuJI"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53328262efbso24391cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 20:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790393580; cv=none;
        d=google.com; s=arc-20260327;
        b=iI+V2D9YUMHZgqupDRKl56EY7+Kz4s3B5TJF3X4wBfJw5bqe8jPWecAYka/Pw6mrg6
         LPF+j5Bp2+PKyZY4ItQII0Se0LZin/eL1WpRL6SJtCCNpFxa0ZYp32eKvYqew8UWgsHK
         /p2R8a/cc3Yw0npuqoJ4RIkWkjeLuxfrdbuAr2Mfj4FyM5HOs7nBwqxC4Bau+VEYsK5H
         pFHkpDdllSwR0uzM9gnMZUrONJ3wrZYoGEkzVia3tHL0zBMPoyxAjl17XEw1NLscjt1e
         ZJd5P6SLkIzZkCur8A2MeSMbJ0ywZoiWz9bGCf1vqZeM0mpqepRr6xoPsiYuOXyQCEWj
         g7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+uCSvMpSE+JPBUO8LTByUk9lpkLbBmHFzIVMWFzxgaw=;
        fh=bYMfkSPlw9m4epK4Mwq3bCmIsNDYk34FpLrgI4h/zt8=;
        b=L/JlRqBm6DrLSAiIsmGZOSmu6MloUbA55Ghlv5cTKtSFodQb9OeHNa4w9wio0L5obw
         D8r6dOeNrVvnQTcLglIoC+72BGNqqUrS8ySHnxhCWyI2X+A17NqUp/0VRqDmNkjmYfOf
         qj+HIe062KMIFFDiXYtdXgk5UZBI4bPzdwlPov16Ci7huxw/dpdknKXqxOf7VNwBZHe4
         WwO4+vp/b8JYM7UWdlf0ZCotyjv0xXtpLPsM5gCP3wI5UjY5BpkrmYgo+cOQtJG3kfli
         01ag+CtcUgS07shteoLSPGTxdgYRg761+pIVrNIygwq2ydLSv2D8Ihi5ayvDiIFBlPjS
         rEFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790393580; x=1790998380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+uCSvMpSE+JPBUO8LTByUk9lpkLbBmHFzIVMWFzxgaw=;
        b=WVriEuJItxd3dx61FWbAq2BFcTZ5g17EhX3ymbqaMvFMr0SU1/Qk9Z7qK0Qq1BNySw
         2P4AS3Gcx9lSPgWV+N7lWWhn4aBKfHRr1j9+oQQYQknOLL0t3LGSiLBQDI+0FmHEx7zF
         +XRIJ3fd5IysW/OVkjflA9lC7BBvFx09GyCXmkVcHQeKt1Np5jBA02TMV5KlJ54ys1TR
         ytXMVvjr1KV52Bxh8LxgQ6WoglKWgp65BdGo5ygO5PBG706a2esSlIj8Q8g+XlF+8N9B
         eV1RPc0FijG7WRsbQSOmV/ore9GvaNqn97DGD4qRUQ88hoobFl0/twideJJVFDX2hK9K
         kGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790393580; x=1790998380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uCSvMpSE+JPBUO8LTByUk9lpkLbBmHFzIVMWFzxgaw=;
        b=o9SrSbZDxTaqTBFQxSj/3CbfQhMWQ50hjZSn+YeqNOV+ienwLndbkUshPl/1ox7XI9
         B7PPXHjtSBc21jAwFVNxKXP8KPv85Y0H5lu+VaYqEQfeLthEWyuFAFiWrnvzKbtSOBDL
         ck6iGJOJgF/IvDnaBqIvCcW4SWI/QjCYYYB2NRqwDzA6uxcnlNlkP4WOd7CJ8ETBeetZ
         k43Ifl+84SmP7ZD2Oo/WSlw/bPzMu/e26fexFVGM/AY1m1Qyz58sT7FIy4al5P6W6XVf
         OaHxPmUa6/U+SVGwxPtOBq+8A4jK0R8ohOHv2pvNC/YholWUDNytaKkLr7bVtdB99baN
         bgig==
X-Forwarded-Encrypted: i=1; AKwUvBy9a8Hiv5bDo7y1ZSUHnQtzpRmUGWCfn8SS7VNx7JPYkV4YLUT4PcoEFWrPWM0VA1bMxFye5yvuaUeZ8t0lzfwu@vger.kernel.org
X-Gm-Message-State: AFuF++lHJap2dxVAMFAT0WZhHAgCjYV2UCFRs0Ur+fOxkHwezDx8Qmx/
	NgMg/Y/4k1foTPQ5vncLEHGdQeIebrgdWzeKLD6HF/Q8pPH5yBEzwhYA+yz+JlyQ7LxKRq9H6im
	yzfZ43gLCvvdEOS+JA0SBbQgW2Yj5NHDkVRbk66YN
X-Gm-Gg: AYBFou27HVUzAOKUc4RzDUXk9fO/KZ9BOsghj9cIIv7JCoKt5TKH6MdZCOz1NLuC9rZ
	ZsgWcsTxXdz6eNc0mZnlNyKRe/Hbc83ZCah+LzRWcfp3FVOC9qeTyBW8haPGcWrhMEgLELlZXkH
	cNNJDY0rzbte1V+I4eOZpcgLdYiU8Eh1GRBYgejLOpit/T3y9whp4TdSKyyvs8GAGP0+73hA4qn
	14B0hu/dQO4SiTWZx6HszzVctEiC0t4aZlx1V8eCPAqxBZblW0qqyJ4RCeqXozyAVU7J5voDrY4
	eGpX/d9D2uDOhO9IJ8+Sx2teVQo5tlHGwCTzQJpxqWkZGo5NXUJg4hE=
X-Received: by 2002:ac8:5c95:0:b0:532:eff9:ca08 with SMTP id
 d75a77b69052e-53320176517mr3678531cf.12.1790393579518; Fri, 25 Sep 2026
 20:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807071818.718751-1-irogers@google.com> <20260807111818.GN687043@noisy.programming.kicks-ass.net>
 <ao90ncOA2Ce8ezIc@google.com> <arc2CZ5SrPlI0hF_@google.com>
In-Reply-To: <arc2CZ5SrPlI0hF_@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 20:32:47 -0700
X-Gm-Features: AclHuK9Y-s7mwnYOc2bTtxVwmooo95aKKvfwHl6gj3vOPc0ZaRqs9Us7YYM1Bps
Message-ID: <CAP-5=fVbfU+eCqasH7U5366jgHzP-7+H5Lg_Vm5-C_-dt5ceKg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] perf/core, perf/tools: Add PERF_SAMPLE_BUILD_ID_OFFSET
 support
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>, 
	Gabriel Marin <gmx@google.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>, 
	Rui Qi <qirui.001@bytedance.com>, Howard Chu <howardchu95@gmail.com>, 
	Chuck Lever <cel@kernel.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Aug 26, 2026 at 04:19:57PM -0700, Namhyung Kim wrote:
> > Hello,
> >
> > On Fri, Aug 07, 2026 at 01:18:18PM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 07, 2026 at 12:18:10AM -0700, Ian Rogers wrote:
> > > > This patch series introduces PERF_SAMPLE_BUILD_ID_OFFSET to the
> > > > perf_event UAPI and implements full support across both the kernel
> > > > and perf tools.
> > > >
> > > > Background & Motivation:
> > > >
> > > > In order for perf to translate virtual addresses of samples into
> > > > symbols a file and offset within the file are needed. During event
> > > > synthesis perf will create mmap events to facilitate the translatio=
n
> > > > of a virtual address to a file and offset by modelling the address
> > > > space of a process. By directly recording in a sample the Build ID =
of
> > > > a file and the offset within it, no synthesis is necessary. The Bui=
ld
> > > > ID and offset as a pair are much larger than a virtual address, so
> > > > there is a trade-off between synthesis cost and extra size for
> > > > samples. These changes just facilitate Build ID and offset as a cho=
ice
> > > > for perf samples and the user can have the choice to use it when th=
ey
> > > > believe it is advantageous.
> > > >
> > > > In practice perf still needs to map a build ID to a file, so by
> > > > default this change keeps synthesis to allow this. It is expected a
> > > > user that knows their build IDs, say through debuginfod, will disab=
le
> > > > this option with say --synth=3Dno.
> > > >
> > > > The kernel support uses the existing build ID and offset support us=
ed
> > > > by BPF stack traces.
> > >
> > > That is still a giant stinking mess that needs to cleaned up.
> >
> > Then we can discuss how we want to handle that as well. :)
> >
> > I think this work would be useful on large systems with lots of tasks.
> > I've got reports it took too long on synthesis and timed out.  Also it'=
s
> > racy and easy to miss new tasks..
> >
> > So I think it's a good option to explore and maybe we can make default
> > once it turns out working great.  But I'm afraid it may need some kind
> > of optimization to handle multiple addresses like in callchains/LBRs.
>
> One more thought.
>
> Maybe it's not a good idea to traverse the VMA tree in NMI.  Can it use
> the deferred unwind framework to do that later?  We could extend it for
> non-callchain data like IP and BRANCH_STACKs for user space.

Thanks Namhyung! I will incorporate this in v2.

Ian

> Thanks,
> Namhyung
>
