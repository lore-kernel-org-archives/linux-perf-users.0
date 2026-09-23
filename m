Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46951DDE3
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169375; cv=pass; b=c32vBkugne/kqA4eyvBq+Ql9sX3PQDl2SKOdBp1pQSx1Yg1SLrJa5xId53VC9it28K9o5oIB8suB7KngxCzhkZ+lD1QiCL8uoE8rTr5rzRv6GnhTagMMX77i+Sx3CofDF4ptzt+oaKBGnHsBMcmi35oi9C8XSRSZY4gZbSSAsLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169375; c=relaxed/simple;
	bh=snwoyxNXVlKFB5fKcSd0aMGn3NuWTS5ye6M7p/9D7X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWsN/mIEvD27HR+BYYwsrm6j2+/PoTEhdIpHExMlXCd7AQYvMnLKv6bhc5sIX4Tf2uHj8s3PUhDc0mnCfJrAG+MT55sErjV0N5yqEuPBhvHAJ2A8kht0oWUrutotJaGcyBcCW27Xt4ip31E3dl8+GsBS5e41sML3+M09zCTPOFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bkOxoVFI; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkOxoVFI"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52faa58bff5so214891cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 06:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790169373; cv=none;
        d=google.com; s=arc-20260327;
        b=EfKF6NDjDr7/m0v7g7iIHo6daQof9iR7abn+iMSJmKfLbNI8OEoEiwX7WwOGJi3YgS
         7D2YkbwM7Swn9NOYKphA+8KooSgV0I+mEXFFAwa60iteGHbRr8d7a4F0iQtp7UQA2eQL
         SNcXiZ4nJ0KMseyTB9rLpo40S7dj3aRgMneFjYC1LloL1Zow4uPH8clnq+s7feJ6zKfd
         1Hnz/fb9sk/ed448r7Zi/TSOGTh/kOQ882nsXR6tj+A84K/kyRdr9rAgwlg8DQy3phBU
         AEHKifzy44tBJ9M6K0W3K0+CCTEKdlMZyyd1+pXiHAmNx8a1B9LrmvBLtQswi+wNsV98
         9gUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7BLTiqeV7YYD2gkGj5l6aVp8svLGEPXSs9wDu0RTUH8=;
        fh=P0PGRuPP9S/7jcOr02+taDMFHP3s0VmklHjdBdysYhQ=;
        b=XpQVs0vY1QsoP7iHZdf9+kLQXts4gNOc5zzwYx3mcZyxVmYiEA6wZ8fxcdItOX5YKC
         QEf6eZ29O294kcayz41QEwak7tE3ShNgFY11IT5fhwXMEG+4BAkR1DEOul6BCzQhSH5Y
         Bq6luZhyQ477koDtKwDW/VOtlcBICo4kF+bLbfh1OKeiidkDOyUlCNMSvxi8klCho/OF
         JuA2sDLllkrmAKP13ck9Zcni9Kjqvyo/C1S2pdhxRJzvIn7YkVqVtq3IqIUUIKkFhUlo
         /xigTiMee0rFkgmfhmEFcSPikq97UqoR7ZhE4OPiAVEGnZPUrO8Q2rodouqGV+9/rkf3
         00wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790169373; x=1790774173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7BLTiqeV7YYD2gkGj5l6aVp8svLGEPXSs9wDu0RTUH8=;
        b=bkOxoVFIRHWLTHkspr4JHS+l/SXFQI/3k8O9ewnZbtD24Ke7g6q0trZS9CrbT9V3+y
         iMTI3xBIBkY+3C1Yn+vi0ujyfJtEV0AMJdhxaDhOuybn4K8Ma3G375AJi+uZAZmlu/w4
         +6LV2H++klIB9y0t/4sNR/UHty041wgldrxUOUXPX+R5ysdGR2ZNC8LykxHcPswK+fhb
         CtjLP//kGuCyfgfNvTOaQ+/wcNQ90TDdLVjkwm8Gi8qSaDWqcSc7yG8qO1HDFiCNOAPG
         GT0p/Qk28kRZrAFpeTLbbksE9RokDlDNeo0VJLmg8M+8B4Tc44Ng1a6T77+X7461KEEX
         GRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169373; x=1790774173;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7BLTiqeV7YYD2gkGj5l6aVp8svLGEPXSs9wDu0RTUH8=;
        b=pzA5+AptKWTAyk25OvUv0fPLWvvqgUT2outEDFU2HOycL3OHXDh2OC12HheUKBayNT
         TJ8G3zA2cdmloI3zMFpxt0fJn9yA5uzODEWoFxzNKh90ty85hkddvVhqfq+yWOKkbFPP
         aoXOrEkK0LMBzH+R0TCvmYpNvfcLqrC1FOi16he/AjcDGdrimgR9R3SVHV4KqDKi2i8H
         oOV4xFW4gfGoSTjCg7SHbA5rhQKFtnn4NOsScG3Pmy1MLeFbGKqgXvJbQtT5VLvrfnKT
         FNnCf/3A17eQYpvkqMViU2BXqI79IP7ttLkVg+nh0D5CTzOTa578iwh2C3OP+e0f+vNh
         OhOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOAbPkL30QKVHayHKpJEWCzAnMCmTJlneT6qg3bu4V5xZOq9obdssukApck0ntfhvj18KnMFGEz6CCUDdTbKUh@vger.kernel.org
X-Gm-Message-State: AFuF++liubqtqIKI9/n8oLjv9Tr+2c4n5kRIzMzE8y5kpP7qkMgv7tGk
	3n+Gwcti6/4n4cEzBO0iuqvy65QHIFzITtuCuuZLTHBTlyUPehvRDSkTszARXA1eFf1IM/vwm0a
	pEf9TPBw+BmL3y6HGjSupaicNCq7QMgB9ag0PHuH7
X-Gm-Gg: AYBFou1J9+HJTwSRphcpLrVRU4DjvLLDg0Pe4QMpXHmP1hZrPnE+mR4FBrYg4WKAvXm
	lBy8JcM8lDJ6TJxuqjFt5GbavmLL9ediF10fqcW6wlcfxkTV2CE+O7KSVAlXTrTojpRcXmg+m8j
	3adN1ZYkUkgm6i4/6/LaDWw9riPyYlrfVmL35+jrgdPlgKrVRgintVv1oaiKuLkpQ04c7ESAsfr
	wPxblg9jb4mU7md2dUgngruhm6IDR99S+HG8BKPVTvsqX7vlJJfX4KsT3+7W8U2Qmu8LQHXLbSB
	ydT4acPejrJ6fybOeloUEBEBb32oeVpibi7ePD6gP0xBkpfiniXbO8Y=
X-Received: by 2002:a05:622a:2b0f:b0:530:e335:4ef with SMTP id
 d75a77b69052e-532eed6c6b0mr13407931cf.2.1790169372006; Wed, 23 Sep 2026
 06:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>
 <20260923090007.GJ200420@e132581.arm.com> <b823478c-5799-4b23-9e63-774a02082dfc@arm.com>
In-Reply-To: <b823478c-5799-4b23-9e63-774a02082dfc@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 06:16:00 -0700
X-Gm-Features: AclHuK_0nK_1gDVkKAoq-aIsf_LXlLKzX0Zrz-YCgQaae8BcfD5fBc3Hpm0oAVQ
Message-ID: <CAP-5=fV1_HfvFHjZdtscCAoYCHc_BBKmNP6Z+kehKHzbfSZ3JQ@mail.gmail.com>
Subject: Re: [PATCH v2 38/49] perf python: Port arm-cs-trace-disasm to perf module
To: Leo Yan <leo.yan@arm.com>
Cc: acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:08=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On 9/23/26 10:00, Leo Yan wrote:
> > On Sun, Sep 20, 2026 at 10:06:56PM -0700, Ian Rogers wrote:
> >
> > [...]
> >
> >> ---
> >>  tools/perf/python/arm-cs-trace-disasm.py      | 356 +++++++++++++++++=
+
> >
> > A new script is added under tools/perf/python/, but I don't see the
> > legacy script under tools/perf/scripts/python/ being removed.
> >
> > Should we maintain two copies of the script for the same purpose?
>
> Please ignore this question. I saw the patch 46 removes all legacy script=
s.

Thanks, Leo. Yes, this is intentional so that if needed, we can land
the ported scripts without removing the previous scripts. We could
always add and remove them together; I was trying to think of ways to
reduce friction for some or all of these changes to land.

Ian
