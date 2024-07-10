Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F232A192B8E
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jul 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619163; cv=none; b=Zo65sJ6jQAvEPLHV5n9qnh7163k7lRMXKnI6pYgN+7Boe+EX/6kZ/rzU4oKuXvZP1jOdJk4oz1uMl9nmjOaxezOO5N4G8WaHwQtlLFe9kIEF7KObkVw9VZdCNzosSeov14fR4/87SXUR6AVK7WStMEK83zihhAyUIN4LdghOSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619163; c=relaxed/simple;
	bh=yFybrs0fT77vAx6LB9Q+WEolILPmGGXFfxDgKNlkHBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5y21mUhIU/V6kpdyk2Ne4ZZmAqbMzSeI7UVCcPVVSuoLUMK6p0aE63pLAqSIA1SK0OEQevSe4nM3OKdoqN/ZZilfIWHbvKIVSVkumkXzYcxdpmTuoJmPNPbgXi4ozZp1xrdVfX908+gVl03+hqPADmE1xLXABWbafLIrTwkJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHHj/1j/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHHj/1j/"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36796bbf687so3473339f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jul 2024 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720619160; x=1721223960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuFvfAozPQGM3so90zXgathbYTyHU4zPzhPqAECnNAc=;
        b=cHHj/1j/r14lZVD+vL0/xe7s/s4gc3axSKf5aAak6zz7KVIBieVhR5AIp4yaUi8JI0
         b0yv0TC16G0DbErO3zAcS4nFnUaUekQLnWINI/O1nGIpjSXNm4XXa4vbg+0Q5DQI50Lc
         0VizIHEzceKrdQ8MRymvoEhJUrM5yL75vlwrgtOKYm37qhWcceaBWrzFqNwU84vTJ/ET
         K5QvjVICOy2MovdD0O2TbvQE1l648wNLhPAlylhp4F60Y3xm8XD4SmTPRuw7Ju1O5LQG
         Z+NJfYACGFuqzTMk9E2JAObkUaXa+uZW0i66NYkThLM3zrLrzysJ0Jc0a0KFsS+0//IV
         Oy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619160; x=1721223960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuFvfAozPQGM3so90zXgathbYTyHU4zPzhPqAECnNAc=;
        b=LODSEgfazxgS8hh6+APv5OYE7mJt73ivrCUWJWRw9IOf6dOs6F84AqhO1+zrNiQmLt
         sWNUXOYi6YDxe0yQqf2xHv0KOWD+6qJaSGJ7+rLGA5rFhZxr8uwSj6ruvlNhw87buGcl
         3R+OI7b+CkjmcMNaK4s6xkM8PvXEA4N/3/m8RUTSJXAd3H8/PHX2BKV8IjcrDl2xPQo4
         SsmGdQqsJPfF/CujincsBe4AOT1a+H9W4ivmYd7WPwvxC2gb9DxOMt0tsENotYeM/K2M
         Fsxs7Iz1wkNr22Twc/j84NWOyu8Ql/XmWRbejGsEHYQ0KaA6Js0xWFDeAUpW8NRtMqLH
         GT7Q==
X-Gm-Message-State: AOJu0YxlMDWVqtM6aK+72eohSOYD5jH2IdXH3PNjTNRQPcNWXrIoiQhl
	FO5XZhrfg5p8C+3tE6Xms3thz/aE8ADEgTSxlj6MwSg0o5I30eeYwpZFD9ZERus=
X-Google-Smtp-Source: AGHT+IHRw8wRagXNh5GbODGGloMCC/O4XEq2eqQ+Yy92BqIkE1lqH7QX5XV1rVk8XN7jhfkSY5wk/g==
X-Received: by 2002:a5d:60c5:0:b0:367:4dbb:ed4e with SMTP id ffacd0b85a97d-367ce5de7c8mr3768300f8f.0.1720619160328;
        Wed, 10 Jul 2024 06:46:00 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa07dasm5336374f8f.87.2024.07.10.06.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:46:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com
Cc: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	robin.murphy@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf pmu: Event parsing and listing fixes
Date: Wed, 10 Jul 2024 14:45:53 +0100
Message-Id: <20240710134553.768993-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAP-5=fWVA9sEn5JbokUipRTzu24HZxxYyHGPrM5soKRb4D8_Kw@mail.gmail.com>
References: <CAP-5=fWVA9sEn5JbokUipRTzu24HZxxYyHGPrM5soKRb4D8_Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>On Wed, Jun 26, 2024 at 7:55 AM James Clark <james.clark@arm.com> wrote:
>>
>> The second fix is related to the discussion here [1].
>>
>> The first fix is unrelated but I just noticed it while fixing the
>> listing issue.
>>
>> [1]: https://lore.kernel.org/all/ce31a50b-53db-4c6f-9cb1-242280b0951c@arm.com/
>>
>> Changes since v1:
>>
>>  * Add Ian's suggested-by tag on patch 2
>>  * Fix mistake where info.pmu_name instead of pmu->name should have
>>    been used in perf_pmu__for_each_event()
>>
>> James Clark (2):
>>   perf pmu: Restore full PMU name wildcard support
>>   perf pmu: Don't de-duplicate core PMUs
>
>Reviewed-by: Ian Rogers <irogers@google.com>
>
>Looking forward to an update on the bugs in:
>https://lore.kernel.org/lkml/CAP-5=fWxdZ1ibv7Pi0L38+NF-vNWZCtcDS9JVf6k3z9nDsrQQw@mail.gmail.com/
>
>Thanks,
>Ian

Hi Ian,

Thanks for the review. I'm just finishing off one Coresight thing and
then I'll start the big.little default events one:
https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/

Thanks
James
