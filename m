Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91C334C3B
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170874; cv=pass; b=q4lhfTDIpVf7WjOkJnb0J/U/uNt5Bcs9ldMUeSjGjJaFsiINuFWIOl8QpGIVViE9fuzaLueCpbZmpJLQlSsUhZ45h1bStrPblkMsnkXqcTMna+9DVUmfNGRszKXXrlw038L6boVebjPX0I2kn7MfvPCOMSeE4creS/OdV0+AhGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170874; c=relaxed/simple;
	bh=+mQ6Ar0lpDm09otDuf5yoTENE4+4/qXpNbLM4z6dqIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWuwZz7/19U9i0C/t3K2OyW/4GhL7yStiGPvZvxJgx0mTrvyd8Uzwivyaw97K5a+iTW/B/TgzT1ZBSN7djyqMjjRicUEalSLByErAkxH/t/wHTYOX5zpNV09zb0f300DXUagfYzDXgwA8O0V4ijkkXGHx/Lt96oSTAjzxSCselY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gKdGC85o; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKdGC85o"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d8facae850so71125ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 06:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790170871; cv=none;
        d=google.com; s=arc-20260327;
        b=pt2U9nnfWyk/z9/jgHlslC6dTKk6KcJUceo6n6ZFLVobpdsbQ97/beih8aHtwZxItr
         k1uTIPNOXKUU/lr8hSRWuDLUPjpzJgGozr5Bvq7iKZrC0cypFyeoIdM3/hQZh8oV1SsF
         isHXLB8YI0A9byBgu3ziRoU/AoYOPNEczlUKyvjlp8zP+GjpUrFvGGu5kBgc6iwJQgci
         fCyO0vYKiBrcSam7CeTpiykJ29w/Tx4e2l+Uywygg29+Dy4x2Qwq16GSZp/eAB+AHtog
         wCxK0XUTtz61iWsH51MwYe4g4pZCxfqOvhWCnHLhr+gdnqFIg5Ntb+MY/9mTP+m4APwW
         eqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VMA6nrkSU3W0ATD5ypT/W2DVX30FCfF4aQzSCkrPd8I=;
        fh=tlQlL/h4B04Eo04s6kAOw3/iFHn7/ht+2Wb3LqOFPtM=;
        b=jX+G4casW/2l1cLWcZjIFkaozIdEx+6XgoWnii9GPDFglJ0LJcyLhv+bv/G8JvzrRA
         AvdvYPQjN2UTxG+UsGT0AQxIsMSxb/Rfb3VJ4WM+CaV0kPxzq3yjldt5SooPaCw4jTUT
         sK99c12OpUYVzXoJKcSjawW/x4KcI3qYxggbp1cZZb9rYdhHrPr5Qd0ty9XmwhqhSRIb
         3zfYwB5ks21APVHo1/2YsW4bGoSyp9Fm3wkOB/0xvH/cP6MrtVsJ3xaQRD2v88XtYWyi
         MfFmH1sOeVkUFgG42jZhBFXguKTPSFUIYvRrigCkHxfYkEGHtwiKaD5gAjU9XKOZo254
         uwRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790170871; x=1790775671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VMA6nrkSU3W0ATD5ypT/W2DVX30FCfF4aQzSCkrPd8I=;
        b=gKdGC85oe3qi/c5bTVtVroUeFXQ5jutC204ZQ2g/mYFkVPghCS6RNjhcoSQ59k5rgf
         IftOu7ifkp2Q1wpXWOS8Gn3MwzUJPaBFuCxZSoI9i2H3bsXqCs7Im+dxX6cpyTlYFA9T
         iWqy9awvMLfQCNscHAbYNkYl1VLjCIMX7HyJcx2dyYlp6ZA74xy5oZtMMrKkqXBmYhvF
         ZcrWE2YZL4J2Hz21rqm8L9xF4V1DoP+LXhyr+QWGVs2lnWRUcKgsASScyvfPup8geNS6
         y31pWEnvDDJAhf97gOxf3sXA5BJG31kM9fBgx5ZMUp7bdSMYpw8WxCm5NV3N7rj1fl4u
         D4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790170871; x=1790775671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMA6nrkSU3W0ATD5ypT/W2DVX30FCfF4aQzSCkrPd8I=;
        b=14/ecMJRtJMX4DG7mqRL85nFRT5LpwFrZ5pHNLAypWx4vS3Kqm169eEiVioJIgMGEx
         t1HIhDnybsxRhalFD7bL0FDayc5xTiKx2WyHG4ND88y7HmAr/e1KR5f98pAIA0nxHDgR
         KF4j8AYwb0jSkMB7vdtPY/sUKFcEeIwo+/fiI6lJeBFVBkm/Wek6zz0hxmu8oGxxanhS
         Q+EkddP5pq4jxSeQ5NiIzBC/EQPfR4EfkQj7ZUsXxAg1Z7yKdrljPBQ7vQjrJAsk8g9O
         Q2UWqdLHPQHFFIuHaiBzY2uGWPG5WBztMYgiUXfoUd1HVlgarDhXz8xLVaeCkrh+Frzp
         8glg==
X-Forwarded-Encrypted: i=1; AKwUvBzi8RN5eteNR6a5Sj4o3WqyINvix/Fm4RRAHgipQUfSW4Sl2MBC0g8NpA4/5EwXipXaXME90m1F6rEMLGJDOblA@vger.kernel.org
X-Gm-Message-State: AFuF++ntyRtsiUu6Ohepa4FKVSqaUveXo4fyd8VP86NkUPOY00W63lPN
	RqsP4Huei0KXzQDHRpmINBWGY5dp4QXRyc5TTOXGUSIA3jJxgipHwp5NlOqvMrb2Nx5VBTpghaV
	MQyn55AoDSXpRIjvxug9Y8U0BzLH9dbJUyL129hLC
X-Gm-Gg: AYBFou11S9dqzZ0cgQ4/01/Lc0GEii4eowGf/1xhpP95iYpAGVegzIvYtw9DhqM0mZq
	yefzFnzPg5NG4AR0Iuvuir2/xE2Z+k8EECKvOqzdWFHwfaWMNLIWVzSX/89KCamqLV2sHkwa0fl
	Tjwg24ljl/OZkoKaJeDnMEHFqVnwm0CJyWKKra48tAANWcuriffJbV3RbHJT2TY3dJk6ynG/4TW
	VlMf6w2Y34IDXJo+54l5oKRnnRcuN+A8uc68AwSF3SGz6C5tn4rvmJnnbdHqFC5UZ0c1N6zk3dF
	pKSajkbJ+WR2Oi4PhzKDuSFh7RWHjFBDoZXE/vNz0V5UJnd3b3vuUOs=
X-Received: by 2002:a17:902:ce04:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2df6b4a0651mr3820415ad.1.1790170870598; Wed, 23 Sep 2026
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>
 <20260923090007.GJ200420@e132581.arm.com>
In-Reply-To: <20260923090007.GJ200420@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 06:40:57 -0700
X-Gm-Features: AcwNN1Vn_Eha65P1YeIcOKooc5cy7M3LqKbx_9UBvcBjjqFG-5HYHBrAAP1_5Cs
Message-ID: <CAP-5=fUn8hafFn_RJs0vgaZKmeGEvWqRwtC4arYrCgogETXUJQ@mail.gmail.com>
Subject: Re: [PATCH v2 38/49] perf python: Port arm-cs-trace-disasm to perf module
To: Leo Yan <leo.yan@arm.com>
Cc: acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:00=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Sun, Sep 20, 2026 at 10:06:56PM -0700, Ian Rogers wrote:
>
> [...]
>
> > ---
> >  tools/perf/python/arm-cs-trace-disasm.py      | 356 ++++++++++++++++++
>
> A new script is added under tools/perf/python/, but I don't see the
> legacy script under tools/perf/scripts/python/ being removed.
>
> Should we maintain two copies of the script for the same purpose?
>
> > --- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
> > +++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
>
> > @@ -44,8 +56,8 @@ branch_search=3D'[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|p=
l|vs|vc|hi|ls|ge|lt|gt|le|al)
> >  if [ "$(id -u)" =3D=3D 0 ] && [ -e /proc/kcore ]; then
> >       echo "Testing kernel disassembly"
> >       perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- tou=
ch $file > /dev/null 2>&1
> > -     perf script -i ${perfdata} --itrace=3Db -s python:${script_path} =
-- \
> > -             -d --stop-sample=3D2 -k ${perfdata}/kcore_dir/kcore 2> /d=
ev/null > ${file}
> > +     $PYTHON ${script_path} -i ${perfdata} --itrace=3Db -d --stop-samp=
le=3D2 \
> > +             -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
> >       grep -q -E ${branch_search} ${file}
> >       echo "Found kernel branches"
> >  else
> > @@ -56,8 +68,8 @@ fi
> >  ## Test user ##
> >  echo "Testing userspace disassembly"
> >  perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /d=
ev/null 2>&1
> > -perf script -i ${perfdata} --itrace=3Db -s python:${script_path} -- \
> > -     -d --stop-sample=3D2 2> /dev/null > ${file}
> > +perf inject --itrace=3Db -i ${perfdata} -o ${perfdata2}
> > +$PYTHON ${script_path} -i ${perfdata2} -d --stop-sample=3D2 2> /dev/nu=
ll > ${file}
>
> The perf script command is replaced with perf inject and a Python
> command. I learned from the above that we can pass the itrace option to
> the Python script.
>
> This is fine with me. I'm just curious why we don't use a single Python
> command here.

A single Python command that would handle both the itrace and file
processing? We could. Having the script command also perform an
inject-like rewrite of the data seemed less obvious to me than just
having perf inject do the work and then running the script. It does
mean a change for people using the script, and two commands could be
less convenient than one. We could expand the Python module "session"
code to include the ability to rewrite itrace data specifically for
this script. I'm hoping that we can have more composable perf_tools in
the code, similar to the ASLR code. It would be nice to add itrace
support to the Python code with composing tools in mind. I was just
putting off worrying about this for now.

One effect of not using the inject command with itrace was that it had
accidentally broken for intel-pt over time as we lacked testing
coverage.


> >  grep -q -E ${branch_search} ${file}
> >  echo "Found userspace branches"
> >
> > diff --git a/tools/perf/tests/shell/lib/setup_python.sh b/tools/perf/te=
sts/shell/lib/setup_python.sh
> > index 2173215a0517..220d9663f81a 100644
> > --- a/tools/perf/tests/shell/lib/setup_python.sh
> > +++ b/tools/perf/tests/shell/lib/setup_python.sh
> > @@ -18,6 +18,10 @@ fi
> >  # Set PYTHONPATH to find the in-tree built perf.so first, avoiding sys=
tem-wide perf.so
> >  if [ -n "$PERF_EXEC_PATH" ] && [ -d "$PERF_EXEC_PATH/python" ]; then
> >    PYTHONPATH_DIR=3D"$PERF_EXEC_PATH/python"
> > +elif [ -n "${BASH_SOURCE[0]}" ] && [ -d "$(dirname "${BASH_SOURCE[0]}"=
)/../../../python" ]; then
> > +  PYTHONPATH_DIR=3D"$(dirname "${BASH_SOURCE[0]}")/../../../python"
> > +elif [ -d "$(dirname "$0")/../../../python" ]; then
> > +  PYTHONPATH_DIR=3D"$(dirname "$0")/../../../python"
>
> Not sure if this is specific to arm-cs-trace-disasm.py. Would this be a
> common change?

Agreed. Will fix in v3.

Thanks,
Ian

> Thanks,
> Leo
