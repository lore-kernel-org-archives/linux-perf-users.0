Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EC33F383
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087842; cv=pass; b=phGu7P9ZiUbxSyqT0fvSZKFoil2wewaW2jzDl8aOCoMCByNqDKGzxDifL3NQohQEr0gUsCNKwHmKpqb7+aWH0e+gKIKUnN/ZOl85xWYv3ocvtyfznb/XKAWzb/htTWuvDkAZhyqMjsr46A59RpIJGF7Vjap3hfoOTMFeusOgZrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087842; c=relaxed/simple;
	bh=7jHxfJW/i8AcIYB/MHIHCP0GXY5CN+6u8fBLwcuTJhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNxmXyKVQf6oXWq/NVJBl0VIzzxZq3PobZ7jDvXnX1JCQkOk6mYKBoH4+meZ3OwZKOKMtWchf1MNDaDKi4OKR0JAEZTACIcsWBR78Fuq9mt7RtTXC+1nTr0to02n/akTyIXFkbXCzWiCUpfRxU5n1/BiMl8Rag7Y+4mTGay31yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5jJkV/r; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5jJkV/r"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0b260d309so18815ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 16:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775087841; cv=none;
        d=google.com; s=arc-20240605;
        b=h01r9SwKP2K8bRMiAmXmCVJyabio0ZMO5Yw1i7LZ7L9nx6UMOINf6dv1Wyzh7Ysz4V
         T/vdM35C7swO13y2a5TxdFCFW7ntyD4ZRiqNiQ364QZyWu+msKoIBSMwey+Em+h/0Bqb
         jVXhEF2g0jczXMIJ1anCKnJ+iLaJnacpvBso1Mm6cT/TZpCLbZz8dyicgR/zCeReB78u
         XOWzHO/SvUdaVVKG5AtOKD7dxxX9orj0nRczhTd4LRbuetWwQb7KSSTsXpTXsCHNQg/3
         eG0XOnZtNf4BXDlikRK9azMBakqD3QpF4KDgm0kIPCH5L6bdYGDB4gqr40iUTY+dH9lY
         5l3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+yiYxTXLxOfXQvOdvEUmkYdhZ5w3GP+y15pVsuODCvM=;
        fh=e6rvc0ypsSQQvEbQjWdhgy0nOrW5doGwolcyv6zwQa4=;
        b=P4rXJ9QS0oXXPaZYVdQoH/fAgV0AsFSbt71q6uOo6dH5dz6LhlQYFjS6tXnuXijJ1J
         nlustyt+zQCpI2aqgbfZ6/ji6xwzgD1N22qm9Y1voLnk1sQGjrURDMbWaGaak0yj6H1I
         SV+T3Qop4VukXwagqO27aa2q0GIpYLkGBudC5/d9YRx5/3a5sbBEpUqpFIx+4cgzIuJ5
         uY1SCbxXmBk5SOl1NtSjvTih4RUVskom+EpDyvKA+9YF8g3yzfGhjOy+8u+O97wczObu
         yj77fQNZT9TMGsnmIF/xJEBcMXmmt2GIueEsfSXPtPD4BNxVFF0HuuAPCu+7+6j7oFsi
         MnRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775087841; x=1775692641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yiYxTXLxOfXQvOdvEUmkYdhZ5w3GP+y15pVsuODCvM=;
        b=o5jJkV/rwUtvZE00GA4uWOT+KKDIjPk+kSzIenrEiz4dHOEWAF510savcMXHr7HTSc
         Jx2ANg3jLLknTSA9LD/LWh7clRMcYJf1QjT/dmjY+5z+c+CoLlE6G4/4NXdmzcXf5lt+
         jAYZU039jltRT120E21bpiLQLV5Lxeo/LRvYFTd45AjJ3O1b989gdfw71TwzHHRn8Vgf
         /rWdB50ww3LLPmD/t7LdLbvxJZVsUKj2ZyyoA5vEj4iWiZxn7xqewRWWAu/z8SHXUbXQ
         clkXSq6CInSiOqcCTHVtueh8XLbqBobYEYkW1IF5omnNvi90Vov2p9xpFan6QJSoP8HG
         1RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775087841; x=1775692641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+yiYxTXLxOfXQvOdvEUmkYdhZ5w3GP+y15pVsuODCvM=;
        b=kDt73dpXvkpMGD/RZUkD4uQdEB0Hi2LUXf6qtHG7iTVVMht3/DreVS7soMVLJXKEpt
         WyrC7vaLiu5jlfo7Ryyfkk4NLT3JE7SlxqW06TEpjSu8NqwmNcHlbyeiFnk9F56BrK5P
         cC1ZbN5lFz9u+17QzKo8ET7faFwKBl5TtBMJGe1DPECIDwF78DNUymijs3xMZPxAyDD9
         ZQyEyMrbvH5lmcyR8l6ItgSKEetNtM8E6gJawvuTFb0R45Jv/dMb5JL3W62pf/NoXjVb
         tB4lD9LrNe7pPNIN2c3FnQ3NzI/u74Tg3Y3XVchA+LlAO6JPTowaeTEpefSAx0CBMFTu
         G8VA==
X-Forwarded-Encrypted: i=1; AJvYcCXPHoQHM/fVHlVy8xsG6SmKW41RvSLYVEiZEXd04t3wZZL+qcGxS+e6SA/XUBBhTfhKMD8m8MsnneeG5/aoqJcq@vger.kernel.org
X-Gm-Message-State: AOJu0YwEl7Umn+7R1wBscj2wALljLfid88+ieb5Xc3kNAJX48hpFyXKo
	rRTYwi77Cma4gg3+AWSTF98ANiOisbr8rfWmGCo8iuLB9/4r2WQXBYb9MXzel3ikPRey4CAZtES
	Zsst79bDpuS0pc4pmIbmvFsxCxjlDRTTn6xNN8szv
X-Gm-Gg: ATEYQzyJ/rCyP3phV+9f03DyZg6khZw0odv1WBFTRYCIpVb2Li5hgDip9eZLFdhdT5I
	+d17YyLu4ef4c9qT0DIEDGBid+84aHUv+2bjNuYMWnlH50/7D1KQUGCSKIBXDYYjOMoIpL3TTCE
	KjaFZNS9Wi1FuqZSAVFFR96AvVNinSjsvkMAE0aRdrNxJCz+GVm6UBaFmEspWGx36ax7vqxWZHg
	nLT/JwbE78sXFTgj38yjS3XM5tbpkcUv9nm5EYVbj1qGwPlfOB+UpWTPrLnCSyAJfhrPUq6D0ks
	NT1BFuSWMb5ezr7l3wh17t5i9qXtXdqzvCVs
X-Received: by 2002:a17:903:340e:b0:2ae:44db:570c with SMTP id
 d9443c01a7336-2b2785597bfmr131825ad.12.1775087840393; Wed, 01 Apr 2026
 16:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com> <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
 <ac2uvTXI1iknXwyV@google.com>
In-Reply-To: <ac2uvTXI1iknXwyV@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 16:57:09 -0700
X-Gm-Features: AQROBzCmxblpzbVITcBH36ZAhv5JVLQm9qzytuKcyUK3dFPRFQllBd2wdk3wWeg
Message-ID: <CAP-5=fX6993MzAEgB7JeVEU5GcVk3PxhkEjMX3G4EZgxPBaBqg@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Venkat <venkat88@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com, 
	tmricht@linux.ibm.com, maddy@linux.ibm.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Apr 01, 2026 at 01:40:47PM -0700, Ian Rogers wrote:
> > This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?
>
> Are you ok with the change itself then?
>
> I'm not sure what's the expectation when the test runs with a regular
> user.  I assume the intention of this change is running as root..

So the test is failing as root on Intel, and the log output is
extensive. I'd prefer not to have the log output, so we may need to
work past some known broken items. Otherwise, the change looks okay,
but there are inconsistencies: `grep -q "<not supported>"` is used in
the existing code, while `grep -q "not supported"` is used here.

Thanks,
Ian

> Thanks,
> Namhyung
>
