Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB313AA4C
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508670; cv=none; b=UwjNZHLJ5VSFujiblgQPcizK6VQ9jAe/mICwgWEAJ8bpMQhxfMwm51Z64KwQzU1GWw1BKBwLTStcanYgytMPeOHnFslnDkOJcIgd1Pt+x5YeXSJo0V+5rh6BPcAw6aIvD/xbORLWUxV+E7zQ0QLM51veb7+5rrltshioIrBczbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508670; c=relaxed/simple;
	bh=BsuX0TwL2xAavumghQ/V7F80KHhaFw7bJmljx1r1XKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zl7lhRdSlM9K8GRjSFxpnqzUGVBvtzEIxYM7gkfZp5Un6CDlyzCMQJbJQhKZps/MCbUj8xUVCOVL+RkHme9mNS4BwPFJ7//8t5CBo4uEH8DxgMeS4HpOpj+olNObjwneyfQe7DsnmcIoakSwWiE7D6VKU+Bbtmctva1TT1R5LjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZ+OAvjj; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZ+OAvjj"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-375bb80e5b8so3495ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719508668; x=1720113468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsuX0TwL2xAavumghQ/V7F80KHhaFw7bJmljx1r1XKg=;
        b=iZ+OAvjjyM8wdjrQRP6tOy6Y5IUsT6RU/E3/zb/Dtd0QK/UDde55C7N0FyIY1rUUtk
         QiiCPwrD50306mf/fbETCkMpwXQb7hwpeWGLDm0j8P4t/78thB/Fu2xEAfjlvjAui1kU
         CMj+j/jBfj/a5XNYIX9yfj7lZwBs56riGdz/wrnTNRFFq4Tku7HnRgKIFpM55RxAf3qg
         QqNgJ5HOYDu4o8Ix8xAfb3XJ3sdvdRQvRFkoHtcDrhSNabUISnOpPj/1qB3iK9cOXKJh
         oFOKl6dZt71yJkV1COyjmQcoJxbcU2ne9biNvFEmS5n329rGs1B437T2p7X/KrCguXfX
         nzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508668; x=1720113468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsuX0TwL2xAavumghQ/V7F80KHhaFw7bJmljx1r1XKg=;
        b=cbxNlH3TRAr/KZICTT5iYAyvo8g9gRdMuPZSM1AidezVIF0TOH2FbnSoXs/K2AiP+n
         +owWVojZle217jc7wdXLcihgoKLmdW4wD4JP/kPAA60pvTf6BA+/wkT2n8LIlQ6yUWly
         F2fK+/PRhyBsKF+GqZ78I3zsk+WwKSnl4nQn59MKdkMW6yczDlAU59G/L0VYRkG71RIh
         7r4mOOhsDjdxgZ8CrO64vry1BOryYhgtFNqK4GNvrk351SF+ltP6PT744MBX1caxrgm5
         PHO3Ufs+sktCwYAiZGXk1ZD45qYV0EdtgcRkBauPp3a25lS3Css4dRVDFN7CqpCbqZPR
         03ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUieV6OtBNkY0TOCX23ELi+njpC4gq/GrxTa5SRT74qoxDqYGI7ClHTGt+WLdoPt5TxrNg45Qe8bT+tJfPzZbJYTtL5vlXtcW/kTLvh78IjpQ==
X-Gm-Message-State: AOJu0YyGjHHwGPV0PcJPiaTlW0ZNLJecZ/9lhLLvTiJN+bsrMzCMAirJ
	p90yqbVcjEA53Z2uHFQh5Xx1HZxBki2oSMRtzTPHxu+IYZXdVrdm/Gm8mfaz68m2bEPuGbXqHyG
	KUapQYintRsXVmNqCwfstrHISKFLqv0gcf6qt
X-Google-Smtp-Source: AGHT+IGvAgYSYBE307LmnsDUtRzN58DFq1f8GNu4AQnc3KQ2F0CVbN+2P2lh1gtRMhbEOkJmZIB8Y5W99gnsBV9ZJwc=
X-Received: by 2002:a05:6e02:1b05:b0:376:38e3:634b with SMTP id
 e9e14a558f8ab-3795cb30446mr3980715ab.12.1719508667569; Thu, 27 Jun 2024
 10:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627133743.407048-1-adubey@linux.ibm.com>
In-Reply-To: <20240627133743.407048-1-adubey@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Jun 2024 10:17:36 -0700
Message-ID: <CAP-5=fWyDXFPi4Jn1PYTbVCRO_f_8gcp6aaB10=6CfqDdXgkLQ@mail.gmail.com>
Subject: Re: [PATCH] Perf: Calling available function for stats printing
To: Abhishek Dubey <adubey@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chu howard <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 6:37=E2=80=AFAM Abhishek Dubey <adubey@linux.ibm.co=
m> wrote:
>
> For printing dump_trace, just use existing stats_print()
> function.
>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

Thanks Abishek, the change looks good but it needs to be rebased on
top of Commit 411ee13598ef ("perf hist: Add symbol_conf.skip_empty") -
https://lore.kernel.org/r/20240607202918.2357459-4-namhyung@kernel.org
. Recently Howard Chu wrote a guide on this:
https://sberm.cn/blog/how-to-contrib-perf

Another small issue is the commit message should be "perf report: ..."
rather than "Perf: ...".

Thanks,
Ian
