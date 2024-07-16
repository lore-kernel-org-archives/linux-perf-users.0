Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88417C91
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721109514; cv=none; b=ir4eizCR+zra2w3n1urudYV/ReSKgifqRKeEf0EQDliNQdv5+myL/2ohZI8egjlc/75K/e1QiCmce/5Vr7nlxgL+vLdXPCenhZX5k2pJKAsP6y0dDzC3t+J7fDGmltpbEod6Q/bhY4Zo4zl38vbUZI0vDM532KyNbjLsJxYPWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721109514; c=relaxed/simple;
	bh=xf1qw3rMXNNnLoDK37FK4MqsRsg6Z+9IQLZd8c0lWaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHJJowTqp3cYPV9k3h+mBVL3LJQnpmvSKUjVUBFhdPWw9NiCQK/7l9ZHX6deMApx2W4Bx3C4tt/+7T+bTHVF6mwoW6NGGeEEfjDQnitWoDLW7FtEvxiTJXu3ITe6QZBd3Qg0m8OcU+YcqApAIoS1uu0qEgjrwxQlMQYi3rKUlz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqKs4eX+; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqKs4eX+"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so69965ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 22:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721109512; x=1721714312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSfSC/XM78wGov4zqz2bRRysbEPwhKMtEFKkslAHJXw=;
        b=wqKs4eX+NezZ7iuS6TU7+nhwZDWn7FAJNVl6rVXWEcmiCciRAVq7CbtBRWP19ZAOZi
         nVtoR4iHzM3h7F0kZvuA/IRWcTXFQiA/QTa/QMmUm9IPb3lhMOIlBzxwacsNr8nANIWO
         6au7OFphkWIa2hTaJ3J6By6PJG9AOemo40iEVvKcXbyg6CfGQ8re5Go+yrMYVR+XwbVT
         oduXE5KsCFPgtcFVPftnIkK8EkEjlYuAez4tAkNjJC9Q6lG5hBQh/N54PSwTk6r6Ex/O
         kO/93Kh9jnEGGTz7hOUE5K7yaQ9B9wGLtIVaZbzBGTlpM3mKfk6ZF83FCXTpYcPTXVkc
         KtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721109512; x=1721714312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSfSC/XM78wGov4zqz2bRRysbEPwhKMtEFKkslAHJXw=;
        b=jR24h1H25ffItrBnZ0zgXKf6PoMVxA2gaU3FpkDxCzwoAG3bMvlInzzcftW72LNies
         H1iEjioLU8Yd77CJ1FhXUP54xc0K0Uin5lvCvsq7csUgNk5QzEYgHNfL/fl3pS2Cyprh
         Rbk/P3ReQbQVx4iDGAyfdv33D0V+vw0vJwSD9fIL944DG4mRJk8KX8fQY9dJc3cxPqIz
         qPwNvAbNoo3QQhmCGEAp5yfxfmHwrV9JbHOhM8EP04Tftv1niPy+fdoNQPa14G98jTin
         PSCl7bHToGE8eQ3h1cWoLzqwSsF4iBDwETfaQQUqVt4g4sVUKSZkqxHLFwJRMRDU32Qw
         tM4g==
X-Forwarded-Encrypted: i=1; AJvYcCU2qH7kZDRdvray3REyQUfuCarCT2gkiVxkcf4u2IyoRw/1288o1IZ80uMFjilPlLijX/uAdwxK53DbbBfXeNhEIDrGLwJc4NAm2pX2dqO4Qw==
X-Gm-Message-State: AOJu0YxQlC2VHb+2pKBs0pzc24VwV02vIqYhAuklLDzGxxMzrsDSD3ch
	iKjmZjtI67ZJCN9zShSyL/VWnWwuEjxKcJgl93tZVkj6PA4asFxfoolO5fw+AqcCNVxcf4++SKa
	wmwpZKRPjXX3Kfq9+w4fwusUXQlahz/Sk6U55
X-Google-Smtp-Source: AGHT+IGC/BGWVPVI+wbucSvfFkwdFRelYd5o5nGWrZYucW84Xqv4UgS9/L0KH1wG5NeouwftYa2u8Ihl7YEww+4Cuxc=
X-Received: by 2002:a05:6e02:16c5:b0:375:ee62:5917 with SMTP id
 e9e14a558f8ab-393c05e953emr2515505ab.6.1721109512407; Mon, 15 Jul 2024
 22:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713155443.1665378-1-ak@linux.intel.com> <DA123DCE-7607-45A8-987B-34F42B3D9E7B@linux.vnet.ibm.com>
 <ZpXqBqxUt8khEqgz@tassilo>
In-Reply-To: <ZpXqBqxUt8khEqgz@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 22:58:18 -0700
Message-ID: <CAP-5=fUqdnh9ZWthLwBmrMiMYyOFn_wQm+vJZ2MX5ZVgXzRaww@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] perf script: Fix perf script -F +metric
To: Andi Kleen <ak@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 8:33=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > I tested this on powerpc.  It fails.
> > Version 4 had worked for me. But version 5 fails with segfault
>
> Thanks for testing. Looks like this fix is cursed. And clearly my perf
> test runs are still not working. I usually try to avoid installing perf,
> but you have set some symlinks manually and use a special directory
> for the shell test to work and that is not reliable here.
>
> I guess we can exclude the two cases for now (perf stat record vs -F +met=
ric),
> although it would be better to make metrics work in both cases.
> But changing the stat code to support multiple aggregations at the same
> time is too much. Maybe if the perf metric code could also use
> AGGR_NONE, but I don't know how to make that work.

Sorry for the breakage, I'm taking a look. I think we need to set the
counts on the evsel and use perf_stat_process_counter to update the
aggregated amounts. The stat shadow printing code should work then. I
think passing aggr_idx as 0 isn't going to work.

Thanks,
Ian
