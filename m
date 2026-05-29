Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E6382F2F
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075807; cv=pass; b=XCirKzgPEOh4AYUodZ72sgHkkcdbnvdmJnVkgLSb1WsP4gjh85MUZhVLzB0n1++5T+YqDxybVDYxE2Umk8Y4LxjRX7nhTu1wIfghZWIiSxT3Qo7rnMylTQ/1lVfK6/9+vP2fjP7Pi9WL9PT/CoWJajXrgKHhlRyKDeKfi5XTACU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075807; c=relaxed/simple;
	bh=U3TKF46npXHkSeVH6EBKSxYeR1JNqlMjswcdOmSypXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1toTuS+ZMvUKiHkttDDEh4wEAacXruM07bC9kyPor3LmRy3dtPDNfXURxHYCw2xYlj+S6Wk5xSeRSqsMrCQfccjdvqQAqkA0ndKx3ZYZpyFCIEWoXUe3osEg2ijje5rMrXdAA5Cdyv2XqDVkrawD5v9bmQKYSlhnocj7DfiTUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQ8+N1gP; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQ8+N1gP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2911f93cso2305ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 10:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780075805; cv=none;
        d=google.com; s=arc-20240605;
        b=LdryvVzbJg6C85euZ66JbwPX58YebkaOLjkaE+W0AE7KJ0SDf5MVuC/mxfgCtHiof9
         N5hDIP4bB5nlDk9JdWgciYSEoUy3jz2YxUyKPX3PTFBoPxiWfZ1d5cyqOHno1nHqC0JA
         iaKTmP3yHWhxo1eUxuaxM/AqbGc9hJP97mNeWsigVkkize/CMuu4AU+5pj6LZKp45Wwd
         9uKWudaGKmqHcss5oqYUqujFVOLUFGxdedTHCeVP5oVb6uAcrlZrlEZXasj7cO4uH6ZQ
         YW8bipes1pwZ0rczoUX3xWuMLa/LGIAIHePS+62AZnE2FmtDwXj8ahoMMoeVNfqsaxca
         N5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5DAwrgkL2Q4aBfDxY7n0TkOckExbLoECFQkW/ulFneU=;
        fh=RmPlWc1nR67jT5S5XQMIxquCum/c5V9GCcNH4D3coQw=;
        b=dR7dhoc1LsELP4Fs47TPds2Q/HrEE0n/5kPMZX8yh/bk2V7tuChwMTXwNuaXw+x9UH
         UPwxzZP+q5i8v4EIjcvurpYdnd9HwDR1paMBLkVcZVlHI2grizLZPElkDWSJ17lPeDf5
         ZBsVs1boDxnRbF3bm4+2sQ7CzbMH3bkbgldh1yDad5R9OhYzauaMvkoME1t0ceGB2+6r
         h6gSwObohj/RO6HGc6ZQw+mxtDpFICiGq40snKg1SCaF3VOlnPzq7nkBDtTUFPNqSRGu
         3bu0f5d1O1zALJPbnGnGZsp9ZQXv2VLwsXSGncp59xFVHzVYQ7U3+vLpFxpDQVlV5UfF
         Rs9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780075805; x=1780680605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DAwrgkL2Q4aBfDxY7n0TkOckExbLoECFQkW/ulFneU=;
        b=OQ8+N1gP/UGc4TvEgDZ5bY0Viub+BjsTc/OxWkYEk+e/iHSxw9fXOGVYbnwVeuKa0s
         5HxH+PEl9wjqRZzHMov2lCkIYrG7ZVz/senTwK1/7KjWVZ1yO59lq+nThXQc71UDqPhx
         qRJQiuccypbiruA1RbuOPCqyCWHDMJLNfbKU0cblU6xgXFWJOvMys5OSiRxWucJ8vYw7
         kjDf6VO2KDSIK61Wb32wPhrDyADIxVB5YEnrROT8gwHndxqjS4N+Bg6QSNQR0Dfwmi25
         0WgkhGFkNymVc4e1VDy7WMCKjWkCEBOaVbv8nZkhhPqMpvYX+hfXGPvcMYW3qL/VPwI7
         WBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780075805; x=1780680605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5DAwrgkL2Q4aBfDxY7n0TkOckExbLoECFQkW/ulFneU=;
        b=Qwj6un/r5cOr/kl1YK9F7czF5Upm9D4gnhxZf5hREY+0BSwhGGWk2SWDU1X70MpkIM
         fR7Jr5JJdDP+6EO6eIVTeAGTTMyig0S2HHzb1R2CmQhRkoKNs2ihO2KNXT36pCFhKClN
         i42PXN+0ntRPuzDNg51hc0wxVYwzelc4bkYPiYAlsg6N1q4lwBl6mmmTSWtUxfuPIdFe
         efASRz2yd7VHCanFg8ZOEzYtnkJhppqIV4tpr0x70on/jxk5QyuxDZ2v1ifM0RbQ2+vt
         Grj5qVQkPqSxnUHNXk5HHz7MTaQXnpvmnBniTOCgLW33QRbdd0z6FTkqAeLMYcKK1z9t
         rxbA==
X-Forwarded-Encrypted: i=1; AFNElJ9rJDW+IyFJJkBzpwnlxxwqwWXjbjIdV4dPbedv/vIPIMGA96UHim9R2tksCTsCpWWpNYXMVFIS8DaT0Wg3aZ+A@vger.kernel.org
X-Gm-Message-State: AOJu0YzsfRAQRZJaKZANUSUfcQP0iFmp9Jv0XJCPZofyMYssdFKFjozD
	hP6P8TZwo/q+hXmrVCgJC81YBDCtK209FcyInL55R4Vexo1nHJQ8GS33l61QCcX8OU27UeNI8Qh
	0m2RBcvExjcOWrSYR3p8O4ExxPkUoQxQngJJRYfNyNGpp3An4Nw5JEfSJ8WV4PQ==
X-Gm-Gg: Acq92OEF8vy5ADB7CgPmqgDIlzIQPp6Xjc5ErMM11nAUds3LN+9PK3CYq4i8EbsziN3
	rvdC+P0joeCBde0kSBzXQZRxcU00QvczovEeXtcBXI53DboBnVcazRDWLGJqNdHnHiLjFW2VwkI
	nCXKGisFLlB10rxgf/etgxH5cWfPqma5LRvzvWabilAwF7NfwaU/ScHkof5hCzfti3Lq+THVk+r
	JYhMo9Al+4T/B5/mw3aNz7JNXEhumWjKs6E/+0eCB2w8CdtDuhxQNXh9LlhbwwQuFHbiknp/x61
	f110bNvdVTrWvnWDMV5E6uTm8CAJaIRt9PuXtUxZYHyBP8kl
X-Received: by 2002:a17:902:e5d1:b0:2ba:6518:e4d8 with SMTP id
 d9443c01a7336-2bf975ac47cmr86445ad.20.1780075804266; Fri, 29 May 2026
 10:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529082451.591783-3-dapeng1.mi@linux.intel.com> <20260529100610.5E84C1F00898@smtp.kernel.org>
In-Reply-To: <20260529100610.5E84C1F00898@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 29 May 2026 10:29:53 -0700
X-Gm-Features: AVHnY4IihBiN3kG5MNqTYVr73D5__qRxnrg4oSYV7Q3LYy6rgz_F7XAuZuJVdn0
Message-ID: <CAP-5=fWugapi9c-HWx9acm=MzyE=hb0muYwj3w86774iOBnvWw@mail.gmail.com>
Subject: Re: [Patch v8 2/5] perf regs: Support x86 eGPRs/SSP sampling
To: sashiko-reviews@lists.linux.dev
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 3:08=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Intel PT PEBS register synthesis is silently disabled on SIMD-=
capable machines.
> - [Medium] Requesting legacy XMM registers (e.g., `-I XMM0`) fails with a=
n 'Unknown register' error on modern CPUs, breaking backwards compatibility=
.
> --
>
> commit a0d7b85bb399d047c94284c24c34805466f84209
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Subject: perf regs: Support x86 eGPRs/SSP sampling
>
> This commit adds support for sampling x86 extended GP registers (R16-R31)=
 and
> the shadow stack pointer (SSP) register. It reclaims the original XMM reg=
isters
> space in sample_regs_user/sample_regs_intr to represent the eGPRs and SSP=
 when
> SIMD sampling is supported, using a new abi argument to distinguish layou=
ts.

Thanks Dapeng! I think stylistically this is exactly what I was hoping for!

When I try to apply the patch on perf-tools-next it is failing, on
this patch with a conflict on:
```
--- tools/perf/builtin-inject.c
+++ tools/perf/builtin-inject.c
@@ -457,6 +457,8 @@ static int
perf_event__convert_sample_callchain(const struct perf_tool *tool,
  /* adjust sample size for stack and regs */
  sample_size -=3D sample->user_stack.size;
  sample_size -=3D (hweight64(evsel->core.attr.sample_regs_user) + 1) *
sizeof(u64);
+ if (sample->user_regs && sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SI=
MD)
+ sample_size -=3D 4 * sizeof(u64); /* Reduce SIMD regs header size */
  sample_size +=3D (sample->callchain->nr + 1) * sizeof(u64);
  event_copy->header.size =3D sample_size;
```
This is happening because commit daac18e7c42c ("perf inject: Fix
itrace branch stack synthesis") switched the size logic to use
perf_event__sample_event_size, which I believe accurately accounts for
the new layout and so it is safe to drop this part of the change.

> > diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> > index fc9eec8b54b82..2729ad8c6d263 100644
> > --- a/tools/perf/util/intel-pt.c
> > +++ b/tools/perf/util/intel-pt.c
> > @@ -2470,6 +2470,7 @@ static int intel_pt_do_synth_pebs_sample(struct i=
ntel_pt_queue *ptq, struct evse
> >       }
> >
> >       if (sample_type & PERF_SAMPLE_REGS_INTR &&
> > +         !evsel->core.attr.sample_simd_regs_enabled &&
> >           (items->mask[INTEL_PT_GP_REGS_POS] ||
> >            items->mask[INTEL_PT_XMM_POS])) {
> >               u64 regs_mask =3D evsel->core.attr.sample_regs_intr;
>
> [Severity: Medium]
> Does this completely disable PEBS register synthesis on SIMD-capable mach=
ines?
>
> Since PERF_SAMPLE_REGS_ABI_SIMD is set by default on supported platforms =
in
> __perf_reg_mask_x86(), opts->sample_simd_regs_enabled will be set to 1 fo=
r
> any register request (like -I ax).
>
> Could this cause basic GPR synthesis to be silently skipped here, resulti=
ng in
> a functional regression for userspace tooling?

I don't think functionality is lost and presumably the driver is
ensuring PEBS sampled registers are preferred over say pt_regs from
the interrupt.

> [ ... ]
>
> > diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/per=
f/util/perf-regs-arch/perf_regs_x86.c
> > index b6d20522b4e8f..ae26d991cdc9f 100644
> > --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> > +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
> > @@ -276,13 +276,38 @@ uint64_t __perf_reg_mask_x86(bool intr)
> [ ... ]
> > +uint64_t __perf_reg_mask_x86(bool intr, int *abi)
> > +{
> [ ... ]
> > +     if (mask !=3D PERF_REGS_MASK) {
> > +             *abi |=3D PERF_SAMPLE_REGS_ABI_SIMD;
> > +     } else {
> > +             mask |=3D __arch__reg_mask(sample_type, PERF_REG_EXTENDED=
_MASK,
> > +                                      false);
> >       }
> >
> > -     return PERF_REGS_MASK;
> > +     return mask;
> >  }
> [ ... ]
> > +const char *__perf_reg_name_x86(int id, int abi)
> > +{
> > +     const char *name;
> > +
> > +     name =3D __arch_reg_gpr_name(id);
> > +     if (name)
> > +             return name;
> > +
> > +     if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> > +             name =3D __arch_reg_egpr_name(id);
> > +     else
> > +             name =3D __arch_reg_xmm_name(id);
> > +
> > +     return name;
> > +}
>
> [Severity: Medium]
> Does this break backwards compatibility for legacy XMM register requests?
>
> When the CPU supports eGPRs/SSP, PERF_SAMPLE_REGS_ABI_SIMD is set and the
> legacy XMM registers (PERF_REG_EXTENDED_MASK) are excluded from the retur=
ned
> mask because they share the same bit space.
>
> If __perf_reg_name_x86() maps these overlapping IDs exclusively to eGPR n=
ames
> (for instance, mapping ID 32 to R16), will name_to_perf_reg_mask() fail t=
o
> resolve legacy requests like -I XMM0 and throw an unknown register error?

So with PERF_SAMPLE_REGS_ABI_SIMD XMM0 is no longer part of the
register mask and thus name_to_perf_reg_mask shouldn't set a bit for
it. The next patch adjusts __parse_regs to encode vector registers in
the new space within perf_event_attr.

Thanks,
Ian

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529082451.59=
1783-1-dapeng1.mi@linux.intel.com?part=3D2
>
