Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67771428F3;
	Wed,  7 Aug 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056889; cv=none; b=jH2ttVU1OBd8/r2UVLN+vL2umLjdzm/AkvXVQfSIFVXJe2XQ5DzfDkbID07DD3MJA8PttKLoh2+dFsRfEErIHvoW/KRcVmhX4le8QtH1j88yXSLX8LhXKVFobZybTUnuavBzHcYf1kjBgQwa5F9ms1CA0h4QU+jvsGGo6hvYBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056889; c=relaxed/simple;
	bh=76yvAM+UpEbVXx7GXsbI2Zqu+E3evoZtbABWa3EDE0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e59pbqMEHD3fTmIRVOtb+xXylJnS1W9+BXosiyx54BWzosKdE13BTEPQ4DQcVEl1sAmzxLKd+HgM2A4wwgvuP1TqO/6O7EubHQTMR6ZBZYeKuubKctfeEJ8/TVAwyWEymDjePfsjBtFFLaeTxq9zUZ0J2tIxPgjJ33y637Tb+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a130ae7126so126559a12.0;
        Wed, 07 Aug 2024 11:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723056887; x=1723661687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1imuq1Y5pnXOMpobYE2ECgyePeKad/viC/fTIre5Uss=;
        b=fq4LOUSMGjAHAzZcd2ldeiond1XAKWmrrH67AlE7oXOVG1WegT82/Hd5l4nBdjASq4
         oUYU54tmgQlxdjxxsf8zfvv+OLsQssP5E/6TWLUDgWlQJjmvgylJtr9j0vVATX/eJJrU
         x/ySRKNN+tkVcpIQwIt2PWSRz/KSE+k6KhrXiHRICGpkeYiZ562Q5k5eQMNWCLI+GvPI
         dVGyGTxUfmQqjRYrLuPdRbp1h9/sCcX65ghzvTSJs523oMs/pj7hjk/qxtQAJm83X9c0
         2lZgXfliS6fb/wVsQxxXaAHfqnqeAstQ2x45YCXiUrMSyBB70Lv/dmEiASUUhEUqSUW4
         UZzA==
X-Forwarded-Encrypted: i=1; AJvYcCW7zD3+I+U2iFiSN82daJ0wLutQ7RmuL0xc0fQTZABMpqjf4mKe80omspWuScXlLOWnXR8C5H0RXh2lyIOcpC7sq095NdHe4y3ukIsMggCK7ChzhE8EiWoyFDGkRZiFpIaVzR9iyQo70VB/8ppsbQ==
X-Gm-Message-State: AOJu0YwfCd/s/P+QmFrh14pFj3V2YwoP2RmtFF8XMri42rIUET0r3Gsx
	qMWecT1bSc0g+VFda/wLmC8PfyJXzpW1Nn5+W91rz+vMh2H2fEfpXAfMWw2YawwCwR9V3pH0i0U
	OTSjXJQ+kl4OaYfXt5IVqIsJdBZw=
X-Google-Smtp-Source: AGHT+IFd65zGATKjgDD0j0s8JJCpUaylkMJtTo43/IfuQ2vBHNtcKq6DjWD2rDvMABtm8DHr0qojowLr6/VLFX6bp7g=
X-Received: by 2002:a05:6a20:7495:b0:1c0:e329:5c51 with SMTP id
 adf61e73a8af0-1c699581ce7mr27301807637.13.1723056886636; Wed, 07 Aug 2024
 11:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807112924.448091402@infradead.org>
In-Reply-To: <20240807112924.448091402@infradead.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 7 Aug 2024 11:54:34 -0700
Message-ID: <CAM9d7ci7zEQUPTLLUdNci49fJHiM_6iiCn_Gpp05aEPyrJBmAg@mail.gmail.com>
Subject: Re: [PATCH 0/5] perf: Per PMU context reschedule and misc
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Wed, Aug 7, 2024 at 4:56=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> Hi,
>
> This is 'fallout' from Namhyung posting his per-pmu ctx_resched() patches=
. It
> started with me trying to clean up and get rid of corner cases, and then =
got
> involved when Kan noted the time keeping issue.
>
> Anyway, please review / test.

It works blazingly fast!

  # ./stress-pmu
  delta: 0.000307 sec (3 usec/op)

I found a problem with my patch that it called __pmu_ctx_sched_out() for
nothing (I guess is_active only has EVENT_TIME).  I thought ctx_sched_out()
would stop if it doesn't change EVENT_ALL but it iterated all PMUs anyway.

But with this change we don't need ctx_sched_out(EVENT_TIME) anymore.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
