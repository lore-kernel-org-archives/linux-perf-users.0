Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5402FABE4;
	Mon, 25 Aug 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131456; cv=none; b=g2mKEhvJjC3whozZ+va9bk2+qyGn8hSLRUK36vsUm5UAQbw8ZaFQbZhJ8gcoZoA4hbD5SLMxUBW7H48cP8hY26D5EsTcGKnpX0wP8YvXEKmfqeCWF0GzYPno1lNUQQe4sxI4sgDYeKRvWpQ9VYoNqUpqREa1juyMP9PvePN2sc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131456; c=relaxed/simple;
	bh=XfZ62tLuxByRPYy6WjHQSXBDg1A/cx9UlgBoxSwnUEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3HvVA+7/GJCVj5/bPochLz6kdpsRqcr7bDJF/Kq8liDrz2oZDjAD00XQcvorG4vqTdPJ2/HPbj07uD46uS2/sVtIdV5QF7dRYCkC4wut8P6gJ4yga0w1roADay8F/q6hddkjGpN+p/3mUzuhi/F3D07FXcxQXE7WtQpXzgFqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqjuvOQG; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqjuvOQG"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30ccea8f43cso2971609fac.1;
        Mon, 25 Aug 2025 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756131453; x=1756736253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XfZ62tLuxByRPYy6WjHQSXBDg1A/cx9UlgBoxSwnUEY=;
        b=nqjuvOQGsZ8yGSkrbFuKBvZmZykg/wRhf61/OxgT0jspq21ctZk6zq2Mn0jR26aLkn
         nwLxhJ/k+0XI1+uN1ARqaMXRT9c2JFFe2m4QhlWjqK+NMX6E+QgB2jMToMTpBxoI8vfG
         J34+TFOKcnohTB9XVoehSSCGo7ANcX9ycSRGrjIIeh3lxrNddXcT3yTop3xAc66N9pNK
         pnwLD0PDamg+RRBkdI/QIFE5RClQg4sq9xKK5pMBE4Eb5R5yh9hHsZ/CWZkiiU83pFo5
         FNgbYuyVjbsFopukbnc1bvZxDhNmZqtUqkJ4Yvc08arr1dGBts9TmLINhO6kGqeIIYxv
         LFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131453; x=1756736253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfZ62tLuxByRPYy6WjHQSXBDg1A/cx9UlgBoxSwnUEY=;
        b=oLoFWPI5XmKhVehnFS1D3jLGCq5vktC05ovmYK2Wrg3L68FT7QxzoBFRKsOnLdybMz
         9eo3k1wSNQ/rskh3HjVE4dN0DjFebOxeIl3G6dX+xDx9eLQbHu2l9b50pJJC5KSxnTGT
         B0vLMWO8Ebt3r+D6rWpLVKFmomfEiFi/TWb60EX3Gy5NaL+BtqNL8Qm7Um6V11A5Cl+1
         nk4iQQZmInhQNkolkG09CaQaOWlwrdQ+lGSMmhM36mz8BHltwm27MHfVT+W8LZlyfOvS
         Ix82MFkNN10nwNJrKfTWsW9mHz4345RHAu3UYPWQgroxNj5zLawgcSoBed21kuAR0HNP
         7KpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEtmjdpAO4d7l8nLkw2PLCUb3aQbcgXrteOHNSvz4cvZe0tD0RiQgqNSa3bWKi9Eiquv0Z8KQbFyNfJHjMDAmfLA==@vger.kernel.org, AJvYcCVxWMmpBp1Oj8R/XcxQkj0R3eETcc8oQ/URYBy573iMjz/kF5wiZ2dCODgMMuONqAgK98gRDVNqTCNhOn3Y@vger.kernel.org, AJvYcCX6W4JQLabjNidKgUgZFWwy0l0620kz+ke/92zz1uIBwR5yXIdJ6THq1Phh9mIFN+73vyRS+x2CTx1w@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/1/gnS28moYFJXwWWLpsPx48IB/qqbQ3hO1hBcfsDIyL84Bn
	gins/X5qqgw0aUqAhNURyYUQw0NcvBMaNxsY5JXoHqMCqApbfqYYQtjOV73GwKMhQThFhj2CYCI
	Rm8NGGEO5AxdhbN+a3E6Q6a5wYAy8PgA=
X-Gm-Gg: ASbGncsngZ+ah+vstbuw7T3i24QfyjG3lDMeH8jpNezz0DG2y7UabD3yLr0yE1VU4Nb
	q5XcbHMfH23pwQWTnqSMB5nyBadqZnuE5zHA7Wb9aSnKlo1OaA+QhyHNyRthQlUFQNYW29rvlaA
	tcB5eT4+a452FAhKLnrNRUtz24hkOCMahyvrEmvlScFdHHAGqxZTFC7aymvPsDtJtFtXXAHjLTb
	3EBjJ5r/Q==
X-Google-Smtp-Source: AGHT+IFSc8yJZYP5++oyX3zmrWa4FAQwXR273vNyQxNEoAE2cLriN8WjmSnBc4L7oE7eTe5khl35lhborZFipbzMxh0=
X-Received: by 2002:a05:6870:9a86:b0:30b:9efd:caaf with SMTP id
 586e51a60fabf-314dd684ff3mr6566294fac.19.1756131453427; Mon, 25 Aug 2025
 07:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815182742.45541-1-suchitkarunakaran@gmail.com>
 <aJ-ScOp3ZCG6PQmD@google.com> <CAO9wTFj7S7G2bqbiuKbR+o7Y0u1EkYY5GsHasJZLmAo5ZuCx9w@mail.gmail.com>
In-Reply-To: <CAO9wTFj7S7G2bqbiuKbR+o7Y0u1EkYY5GsHasJZLmAo5ZuCx9w@mail.gmail.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Mon, 25 Aug 2025 19:47:22 +0530
X-Gm-Features: Ac12FXx8FORsgG-UWpSZaL1OSNZ7sKM_Gyr2_7qwAfsu43fTiyQJX4R9qb9Mtrk
Message-ID: <CAO9wTFiJmi7YzeukT0VtnpqcJcE3sSueO3owYUAd+H4wjcYZeQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf/util: make TYPE_STATE_MAX_REGS architecture-dependent
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, guoren@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-csky@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Aug 2025 at 12:16, Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> Hi Namhyung,
> Thanks for reviewing the patch. I'd like to ask if there's anything
> else I should do regarding this patch, given that it's supported only
> for x86 and powerpc?
>
> Thanks,
> Suchit


Hi Namhyung,
Following up on this patch. I would appreciate any guidance on further
actions needed, considering its current support is only for x86 and
PowerPC.

Thanks,
Suchit
