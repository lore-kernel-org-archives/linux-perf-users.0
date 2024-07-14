Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38797F
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Jul 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720974209; cv=none; b=HH+I65EHfrFF84vbdn1DNbNgTm0HlUypp2ORKy/kvZOAQsW5OBJ0eaQw+0okb2VRXql66bgDA3O06c08kCsoOk7XoTlMMSJIBd86ZD9Q1BW/PyyBZHuLWIooKqAwDjmUDao8W419Zs3E6MfJX5KYZuIqEQw3dZAVVbvx8lSf+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720974209; c=relaxed/simple;
	bh=2oc17bxN5yneFOqoMD5SfbFq6+mOSKm3ebyqyV12JkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMohgPB+cHgzJcYxp7DDhT2p5AuaSlS0ATA+1ugouD4x59xtEH3Ox9l28q8810KNyBHX/L2qwUXJfiCy1mvwjyPnOzdsXcE8L5VpNvWVOqkG4Zk1hcOGEKuET2CUAYNVgQvxBXFWjLjKIQj6CXwdkPnoz7FlW2oAmv99A+oucLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZtjnDX1W; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZtjnDX1W"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so5449107e87.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jul 2024 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720974206; x=1721579006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFB/7l3RP1NdCHl9DVGleC+3i6+uY6B4g+LS+1Kxs4w=;
        b=ZtjnDX1Wzf3YfmiGS6rzZxu3drWq/f0gWpW3TTu/54v7YoOt+qB7VNjEmfLRFOfT5x
         uCST6VAq5AopL7bsgyNJR9uXr5nQAuA12nMg/WjQgKGY8Yv2ovF7EUZrcsXtIwraIgDa
         o6nuRFUK5q/NjBdnOBlGfA3QqxRXLAX9ewZWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720974206; x=1721579006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFB/7l3RP1NdCHl9DVGleC+3i6+uY6B4g+LS+1Kxs4w=;
        b=F8b3EIFSPqOTB/X6KOjYFYDNgOjk8a+goYZ65AjN4x5g9qmSgGTF2pzszAc3Hgc3nv
         ZQjjRr4Qa0130KmQTIJST+yelYBNp+/E4jhQ9QqLMGy/6brbnYXQF5qIslj/e4X1Yx9B
         muypbVv9NGBh8iJHqDq0NFyf5pCcSbeC+c+U78VhlT9DCCbAxBgokjmxvw9YdJt8xdXi
         ZRhTUQebqW6BDmoNYsoaHVRQvpjExK36EDpePMtcPfmlqynjoTc0NHApZFdOltclh/X4
         IpxnnRO6eTdhQSJXE4znRMU+fJBixR3rok4c9Azn8lwgwPoNjiGaGZxt9kbhtBZ44cxu
         FWDw==
X-Forwarded-Encrypted: i=1; AJvYcCWeJSVnK4W+cmHsu2e1SXWMw+dDzK790DHN+1MrO4//aE3S2NUqoyYFX+g7Y/853wlH6sWIZ0kWw2pVOjig8VLvvnSPHqwprIa0Ytpn3Kw4aA==
X-Gm-Message-State: AOJu0YwMCtMDZ67VvhBM0gU088z2VKz5rCkwGPo2+enHzwC+8YXvK8Ux
	1a1uubUhMxa/ZN5nJdHUN7CTQXA0RxFxSpcCqkrLFI9tKgmE0bI8U3gEJraKn0l9OZv34rdkLl0
	JjgNNCcJZKLmXaALKcU8a2wJVANZhBY0PrFQW
X-Google-Smtp-Source: AGHT+IGGDxdQpMZ3cXJMhqls7l9eRHoLz1SqwrfxhfrJi2Y20XlRfUb3+vsWUPNkvnrnaEgNTKFmsTZfQl6EAlnDcLk=
X-Received: by 2002:a05:6512:1110:b0:52c:d2ab:693a with SMTP id
 2adb3069b0e04-52eb99d28c5mr15290317e87.54.1720974206121; Sun, 14 Jul 2024
 09:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
 <1720700179-22839-2-git-send-email-ajay.kaher@broadcom.com> <20240711214936.GH27299@noisy.programming.kicks-ass.net>
In-Reply-To: <20240711214936.GH27299@noisy.programming.kicks-ass.net>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Sun, 14 Jul 2024 21:53:10 +0530
Message-ID: <CAD2QZ9YQ6n_6J+bq+wNxS5bGuAOsLkSiicigan84qaD+xrjS3Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] perf/core: add logic to collect off-cpu sample
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, rostedt@goodmis.org, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, yangjihong1@huawei.com, zegao2021@gmail.com, 
	leo.yan@linux.dev, asmadeus@codewreck.org, siyanteng@loongson.cn, 
	sunhaiyong@loongson.cn, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, 
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>, nadav.amit@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 3:19=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Jul 11, 2024 at 05:46:17PM +0530, Ajay Kaher wrote:
> > following logics has been added to collect the off-cpu sample:
> >
> > - 'task_pt_regs(current)' has been used to capture registers
> >   status off-cpu sample.
> >
> > - off-cpu time represent the time period for which the target
> >   process not occupying the cpu cycles. And calculate as:
> >
> >   off-cpu time =3D swap-in time - swap-out time
> >
>
> I have absolutely no idea what you're trying to do :/ The above does not
> constitute a comprehensible Changelog.

Sorry Peter, it=E2=80=99s sched-in/out (not swap-in/out).

'Perf record' captures on-cpu samples at frequency which is specified by
the user ( i.e. time period to collect sample is NSEC_PER_SEC / freq).

This patch is to collect the off_cpu sample and time period of off_cpu
sample is calculated based upon the time when target task was sched_out
to sched_in, as:

 off-cpu time period =3D sched_in time - sched-out time

-Ajay
