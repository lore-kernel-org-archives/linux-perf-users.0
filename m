Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6592ED15D
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076371; cv=none; b=m/n9KGmJgF9yGzu7Hh06lif/csqgG+cZ/mmlutajkTur0smIe8u+Mx5TQI7m8rbe3LN26wMdxsungWL3AZHnuwHk9bi8KD5bMXzznAY7k0B1+v6Rj+NtxWyKbd1fvSqzIBoPG0wq+F1P+woZz4Zqy4ldN4sqQOgOLaVUlBALRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076371; c=relaxed/simple;
	bh=zbyU+4bvtfH/pps4khRIFBiU+g5XtLwdwZJoF9L1pwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nf1dK7YvwZRzxpfjk+jgHanssBSKpPJTiilE5b1JbhhN5R3guM8iMTVQuSObQq8422/kwlpckDLoe2cYAiiIxRmgpyqEhYZVPFRjN5LAIcJXLzS2hLnXHptGkqVCzkE8Hrf9iWyM5n78tS8rmSJ8w6rs+S/O7aeSE6R24kHcOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVRMh7qg; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVRMh7qg"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-4eda26a04bfso62479951cf.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 05:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764076369; x=1764681169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbyU+4bvtfH/pps4khRIFBiU+g5XtLwdwZJoF9L1pwk=;
        b=nVRMh7qgj7Au0I8kMGTgRtvBqhEZZnYrUYOADQ6iT98jjkMBytt2YMhbwidz/rGgcP
         wH7AHnB8Iz9NW4tfqUQs5CapFEnzrVhrOMRX6mnEGZM7eT+Y90sKVHyF3PM128aqBlCc
         ZYr5khqNdAHYstg1XT4dC+n1oWcSix6GqoJYt3nEHSUS/tB0zzejaicamUXN9wynRwte
         fYlqK0ww8DGq/vl/3lSQdqI5S6aq2sscHxExyjlA8faopPmUKw19t4Y1yvslhBfx6wOd
         FJji/ND4oxejCSnpWg1nuI/28wiGCO0TtxwxVq5K6Q9NziZM+g1QhFex8BOU1tD6+J68
         QGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764076369; x=1764681169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbyU+4bvtfH/pps4khRIFBiU+g5XtLwdwZJoF9L1pwk=;
        b=O3AEG71Qn1Pajsg6FqMAtsGe3E3gQWSnH4GgqS3wO/F4cPqWO9bIhbBNG/lwojNW9V
         wIMFDf3oPX68+ZBqRy709b39FFoR3v64pnceSLHCvBSrjtZF6yQYp4ZIJ8AMlxd1PCV3
         ZkpQuSCxkmBl730eHpEsnEV933dQ5D8gTYUfEs77LewyGpDJPO9Gy0NPiyLfjJ8mGrgs
         DgbXkFLUVXVkoefTRUd2Q7tRdcTJRiDExWbRnoaea2ddqyIqaESekQizY3VfCbfqv33c
         d4/ksEB7dO8PynJvNRDeSprH2cFQjVOygWBHa0c9KRfG1Ivzy1pWpSIM749SyLHThy7I
         6qeg==
X-Forwarded-Encrypted: i=1; AJvYcCVmuCd4lq8Mtj1JHKEIj46FhwHN+TXSqPFdxgYi3hbNK4cimjgjFTLBc1KZ8Ump5sGZ8WvnUMYkBmGGsddVkPbJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyszYOnb8J2QATLgtL805xVqBCfZHkkcVZyahaJACuQ2z6/uVUK
	lvIXN8GWhlSaEFcTC9jzvcrtPz2WFL3rwxUcMb8byNc4Wqgrspa8hF1z9OjuRk7fEJgfigD9o7w
	tCZhC2bulN+HK1VQ1f2ybHJb0Y5QdRiQ=
X-Gm-Gg: ASbGncvPtotPjQIUAgDGMHgjRq8p38NPFUx+Zz6b4zmCPIgQt/TrdDY3LdEdysaYrzk
	nKkGCyeqUiRIg17RpPEVkcuMcwXvYs8d5le5KwjPtcyuYn1NWvNh4lewvNNmGxW39pdMW9PbNd8
	O5VrIQqwGra8vNyNQCI2Ecn3t8JwByuc5R/T4htxtGupBPof/8fYMWxXtaK2zI3x3BIJVi83M65
	5Er9RBefVBbVsfd95Lug2oIlL3D7eEadyOqYP/RBuXfD3FI+IIcwKflMMaryhfHMjJDpMg=
X-Google-Smtp-Source: AGHT+IHGU003XEqpI5L8CyxzbhM1skfKHKtdo1c93HbYZEg3WQd5fGS6r6lx32pNu0o8tqVuhoelaaNCWrS3jQt21XY=
X-Received: by 2002:a05:622a:1314:b0:4eb:a192:de99 with SMTP id
 d75a77b69052e-4ee5895a795mr184304681cf.76.1764076368901; Tue, 25 Nov 2025
 05:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124072310.3592-1-hupu.gm@gmail.com> <CADHxFxRX2=Mt+BGhpCU9WfAMi9rfUO2x7qLy8tEu1aiSVo39bQ@mail.gmail.com>
In-Reply-To: <CADHxFxRX2=Mt+BGhpCU9WfAMi9rfUO2x7qLy8tEu1aiSVo39bQ@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 25 Nov 2025 21:12:36 +0800
X-Gm-Features: AWmQ_bn22f4Qn_0gJqRgVQQKDEQBirV0Szt2EL_wcPjjvZwzMT7u0eJDLZT97rw
Message-ID: <CADHxFxR=8zSCD_JJQrjUGDWz9g4u8-4qtwdsQNeanLB+TqVMHw@mail.gmail.com>
Subject: Re: [RFC] perf build: Use self-contained headers from kernel source
 when compiling
To: namhyung@kernel.org, leo.yan@arm.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

RESEND for attention.

On Mon, Nov 24, 2025 at 3:51=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> Hi All Maintainers:
>
> The background of this PATCH is explained in the email linked below.
> To avoid potential disagreement from submitting multiple PATCHes in a
> single email, this email focuses solely on discussing whether to use
> self-contained headers from the kernel source when building perf.
>
> https://lore.kernel.org/all/20251013080609.2070555-1-hupu.gm@gmail.com/
>
> Thanks,
> hupu
