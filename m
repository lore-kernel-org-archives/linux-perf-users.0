Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8752B9CD
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Sep 2024 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821571; cv=none; b=XgRnsFXoDMk2AmHXpepinRjqhOdMOv5YsOho8v50Qx2IywzQ69IBR34Eu39SvteTBHhNY+TsBbqCsGIlduRThDmSGhsm8NM5IoGX0oQUtGmcJ/3qZrRX2lpdWMCc9jvqsyZZBWrspsFCqnEOu4XNH+SFn2VKHzhVO3fu0ykE6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821571; c=relaxed/simple;
	bh=3WFWfnOhZubsw9sT5LHqgJIjcv2aaryT82I4lxFX+OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMj3uMhAgSBkEbYmU8B4zPLwruc0blzjxXpBGaCS3ZPnMVj2qQ6bUYLil/kv7fhbnsSgg94vsjVGERJxtak/QQHaSt+IKyfl7NuoyjxpbnUZFRFQqHcJa15tZJ5W5qjmISJM4aQ78mYmGH1vurZ9mzlWmNKTdco1HegIyTpXtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s33DcSrJ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s33DcSrJ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53659867cbdso3611848e87.3
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Sep 2024 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725821568; x=1726426368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WFWfnOhZubsw9sT5LHqgJIjcv2aaryT82I4lxFX+OA=;
        b=s33DcSrJXTXvmgrw2r8c6+qRMDQsUQPrURo1pb2kinxIdlCtWPfQ9YuJG+dcUnqpeF
         WdRy5ZafCNuTpp6E7WnW6FJAId0Ybna8yPJfMys4HEUWwQS13cD4n6O2bhmgrKWBX2AE
         IJPQiyoqLxkKkkd0n4M0ruUNzSelt4axBgxMKrRkLfXOYm8IzFJUCQA7pzvMf91yX+MD
         bPQKxjBaFTuFQzhJIBebC7IxnMAfIUsltSrInIWpF9CLUk8a1JMWqtfRI3oPIrgRtcok
         QJxOapA6ncKcc4nEsuOyB3+85aZ8930i5ZQMJkNYttcJVcfy86V9iGNamEfpb4ljx0Ue
         FZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725821568; x=1726426368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WFWfnOhZubsw9sT5LHqgJIjcv2aaryT82I4lxFX+OA=;
        b=nTQ9GNESyP/z2heUAQP0XSQeL1EskFcfG/MqYrPXwVZiqZWXxVRNMMjM6nZ5nsUK4N
         6dFzuCmD8k31GjLWxlmIPRNf8EEjbkOxFkoMboZyPMCUpd4J8eFXLS8eXqHW6KtuTVGL
         PPThXKUwbJT/4UM33RWT/jgVTk7DW1COm8qsEQ5wW6gbqs5eSNJfhlf3mfWxyh8/vsn/
         Pb9TC8DJsqeM2K3et8pZFINH5b7rPt99AKs/mI87M8Aj66cVqmEQ2WZZA7UvzPK6cMDx
         1OFuKkWUz+HlY2eRklJ4loVYFxM7PVXDtPAhheUXU8CT1iM1Fjt+StSez+9zLgcIBgRQ
         avbw==
X-Gm-Message-State: AOJu0YwV5vy0UTh1+apsyebI11E8Bhkp3cbQCvyYAtNUTWLZYxr+CLnw
	KIsW7Uadd/+IzZol7znwM71Dc0IG6wAV/MWZ+2fZv1vmzGtyDf+BeKLnK2QhEh9L3mvfdaVH+Oj
	O/unG
X-Google-Smtp-Source: AGHT+IF2HmdZdV+xLoqlCpRMWUDenH/fKLqGGrNlpg2XhiKa4f3SsF4G99fJzppscsFxpMcAjrMOLg==
X-Received: by 2002:a05:6512:2215:b0:530:ad8d:dcdb with SMTP id 2adb3069b0e04-536587ae7aemr8612521e87.19.1725821568055;
        Sun, 08 Sep 2024 11:52:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:d151:c3a8:f652:8df7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f903d54sm521483e87.228.2024.09.08.11.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 11:52:47 -0700 (PDT)
Date: Sun, 8 Sep 2024 20:52:42 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zt3yemuoUCXTaClB@google.com>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
 <ZtRIla5pCqlMIKvN@google.com>
 <Ztbga0xLyt1eaehi@x1>
 <ZtcWwANOWyXEnGdC@x1>
 <ZtcaC5WOTj-fh_Px@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtcaC5WOTj-fh_Px@x1>

On Tue, Sep 03, 2024 at 11:15:39AM -0300, Arnaldo Carvalho de Melo wrote:
> Or, as I'll do with debian:11, just remove llvm-dev and not build the
> features it enables:

Thanks for looking into this! Is there anything I should be doing,
or are the patches you posted earlier sufficient?

/* Steinar */
