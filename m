Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBEB51C3E
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510356; cv=none; b=q58qWdbdi8l2bAIupzFf61g3BBTN5Z3hSDxnYIL4dSlWVRchdO6c1uGay8t8RzByUrNL8WOvcmU6JUlBSJTq+aqqmknc40xqlqRYURYxYVeM35ArfrwZWXyoJ0bsSfdFN4zz1voEDr8fpd5soD5Y94YgfsWDRN5j2LViIfJvY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510356; c=relaxed/simple;
	bh=vu2RYkNMGj3kojZRyCrd2+DxBoqFKEtCRWQneRxDP1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqpXvITAXnOWIBnV3sUwIwKUNcZ9v8FaEdder1GWyIqc2WoLGgOkiRmSZ/VNJtyO1JJdndeCeE4xoV67PLZZj6a6HrRRvQ9FekFZ/raNGtmHUeZ0QnAZir03Ea6aIAwEWJ5u9P06LrGy2AglqUgD0jYxtdYR+Yy3TYg77fQ8dMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LE+qwo/s; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LE+qwo/s"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f61742a024so246995ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jun 2024 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717510354; x=1718115154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu2RYkNMGj3kojZRyCrd2+DxBoqFKEtCRWQneRxDP1w=;
        b=LE+qwo/sNbDKgWuyN/3/s+Q9uhiiRiApDXXOmEX6cYTeXX49pbHUEv3dRWKakZfjls
         fddNKgrBNVI5WGtj7W1yabu/xkl5yHYt2MDjFnVUt8UReN6X3ofzx72c6khwnL+2qWJ0
         Ub8Q8OGfwCEcKRfyIymNf0r7emb90Jt9L4bPNyUVYqvwxOYrOefUIbJHDUCFjAzAtLJG
         /RcdLF5yDG2VsCDZiKkZkb6B5L/aaBPV0qRy6ChNFJF3ij/MFfXOSPiCDiJP4TEoGhQw
         UW0L6xyoItKjE0HJTDryc6Jy+i8tq9mGSPyuPbFxqEXfrt+NC8dlFmlo/izI/sZWx4La
         ATJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717510354; x=1718115154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu2RYkNMGj3kojZRyCrd2+DxBoqFKEtCRWQneRxDP1w=;
        b=RGjGmEvWEQ9zZwtpbcl9eYwbrLpoJbwomNGHWj0POry2d/69DCPz3hYtY4FOywQMqk
         xyZl5FXFKO8v+ZGfZwe9GkmxlpIgMWGWIHanBT3XL+JTQhTvpHxvDdRtPCR2N17pqB/B
         QZjp4rHRiNPZSOKxRVly15EUT6ZBLRGNbQ2ToFra4JetdgthciYXTprBpD680Qf077hb
         tm5C146uv90tpSDuMr1jZCQkxlKReZzJpFGJJlBeOVXnZ/9lb9xQbRNEVt9JZ8l+C3Si
         ouiXknEAuGjvJd5vsC8Fa6W2Fmox+HgOWz+OZfzR/dh5nmOAEZKPzpDgMqisHa1xulDl
         9g+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSlxoL7U9E8/SCAbOTvs/Ja8naKtbw0smje5QUUT+7AH76HBkoWJqj8qWHMu7HIxub1Sd9Gi0/O5sJ2/kcP0tl2M09w6fCvPtFBHM3r3gcdA==
X-Gm-Message-State: AOJu0YwVN4LtfCZiNw91zT8qYuPgjYjy+DqqTt06dHkepD5pmeMhl/dz
	BibmAzEguWscybBVYCcIKizRvIBCoO4FA8m7zDxh/fSO/+UVj040aCH3lvGC2nx73LnHvJh5SLN
	uZMOXRg90zYRQZuZpPIYvAByd5DRfDLs3zIJD
X-Google-Smtp-Source: AGHT+IGQlGtZMFSkEZYFWkiBTPtsj/2AtvKhDfZv0P8/Q4Ppu2eA0IoOSrBHLHp+VW7CPm5GIGDCiu0dyvvwDWVLt1k=
X-Received: by 2002:a17:902:c246:b0:1f4:7db0:afbd with SMTP id
 d9443c01a7336-1f695748a8cmr3664735ad.28.1717510354238; Tue, 04 Jun 2024
 07:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603092812.46616-1-yangyicong@huawei.com> <20240603092812.46616-2-yangyicong@huawei.com>
 <CAP-5=fXNumMLL=_+qXdnQPqgLSwo7Z1BFmPww63NkX5EcDRDsQ@mail.gmail.com> <0d45744d-c206-66b6-5861-b80ebcc9a1d6@huawei.com>
In-Reply-To: <0d45744d-c206-66b6-5861-b80ebcc9a1d6@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Jun 2024 07:12:20 -0700
Message-ID: <CAP-5=fVeFG+-5+0VHfzyj7FRRJ5-LFvX6z4OQiT-CVsYzqjREg@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf pmu: Limit PMU cpumask to online CPUs
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, will@kernel.org, mark.rutland@arm.com, 
	acme@kernel.org, namhyung@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, james.clark@arm.com, dongli.zhang@oracle.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 4:12=E2=80=AFAM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> On 2024/6/4 0:52, Ian Rogers wrote:
> > On Mon, Jun 3, 2024 at 2:33=E2=80=AFAM Yicong Yang <yangyicong@huawei.c=
om> wrote:
> > Fwiw, the tool will determine whether the mask is for all valid or a
> > hint by using the notion of a PMU being "core" or not. That notion
> > considers whether the mask was loading from a "cpumask" or "cpus"
> > file:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n810
> >
>
> I see, you're correct on this. Maybe I didn't mention it clearly in the c=
ommit,
> this patch doesn't intend to change the case that user specify the CPUs e=
xplicitly.
> It'll have difference in case user doesn't specify the CPU list while the=
 PMU's
> 'cpus' or 'cpumask' contains offline CPUs: with this patch we'll use the =
online
> CPUs in the PMU's 'cpus' or 'cpumask' but before this we may use the offl=
ine CPUs.
> We still honor the user's input by the handling in __perf_evlist__propaga=
te_maps().

Thanks Yicong,

I'm having a hard time believing this bug has been there all along
(forever) and also what's happening with BIG.little/hybrid that
advertise CPUs in similar ways. I do see that on armv8_pmuv3_0 the
"cpus" file will have offline cpus while on x86 a lack of such a file
causes a fallback on using the set of online CPUs. So there is a
divergence in the PMUs behavior that may well manifest itself in the
perf tool like this. If the "cpus" file were empty we might fix the
behavior but I don't think that's what's wanted. I also wonder that a
PMU driver change will mean the perf tool is still not working
correctly for people who don't rebuild their kernel.

I'm still thinking about this but thanks for the updates,
Ian
