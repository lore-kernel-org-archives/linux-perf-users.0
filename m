Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D2F372EDB;
	Tue, 13 Oct 2026 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933537; cv=none; b=bZBW1K4Xi9ps7T6IWvkvQV+Pqn90yUQUWqa3IgsayAaqIGUBOsni3yj+enWVWIDJR3+E+FAAi9GUSUpLan99Nw9y7Um6QN2doTXT68Z6rMZyTYS7wOOpstLS94Cd6Gr3a553MrvVc2D7x1hm10kASRehJjg3trRVvozqd49Idz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933537; c=relaxed/simple;
	bh=gaxZAFGU6xceCJLiStkWFMvFEc8zbfPX9b1tRC31zMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOvneRHHZv87YJn52SuA8b+Qty3p0gIftOxgd10tBjfbAV/UmxJs9v0DQviUOwGJeqoO5itK5ULueaeAG5alSX3LnaIjjor/6wZprU5NzGxvGEeAAbqHKEmT5NyESJlY5KA86vlyGyI3Lwn2EV7xZ0D6L96+OoVLzTeFJv3m6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TLVi7u7b; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TLVi7u7b"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4j49JH71d4zlfvpK;
	Tue, 13 Oct 2026 23:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1791933531; x=1794525532; bh=gaxZAFGU6xceCJLiStkWFMvF
	Ec8zbfPX9b1tRC31zMM=; b=TLVi7u7bAnPOjzOutrFS95RLd382MwV1NyEr9vi6
	jeR41qJN2cjaXXGxNWaS7WJ7Agtm5BB3qQnBOcC+MveTiKP5pYj7AShWVZw1vtGM
	PbjmqbhGWFSwOzl5l7xN68Qgd4cFyhL4ARs4MS2/uu/IXFjoC+4SuV+7mYhW0D/a
	9v9TbsUsnu2OGZYXAyufCOlwdOFlG9j3AORTh8q9nj50exRa6aoFFozvQ/VKhVAh
	dmirKqWb2WHOgaxaSZrYK8lawRPWEFC2Iu8lCUr1z4vLR/ae1Vz5FBFmCLdacVfx
	3j8Pr3QO1GZTokEU2yD+EoOn4TVk9sVkJUscGy6ka8dwcw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mPbmFxJa9yDL; Tue, 13 Oct 2026 23:18:51 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4j49J94k4XzlfvpH;
	Tue, 13 Oct 2026 23:18:49 +0000 (UTC)
Message-ID: <0e572032-5e5a-4a4f-a362-16ad48f2f02b@acm.org>
Date: Tue, 13 Oct 2026 16:18:48 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] tools/perf: Adopt kernel
 compiler-context-analysis.h annotations
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, elver@google.com, namhyung@kernel.org,
 adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org,
 justinstitt@google.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev,
 mingo@redhat.com, morbo@google.com, nathan@kernel.org,
 ndesaulniers@google.com, peterz@infradead.org
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <3f57ddf4-b1a7-4c91-8983-c8cd83d0f25c@acm.org>
 <CAP-5=fX3e4HRaLXxQhCwEHRuXZdpC0zEEh2pozEEegQBxgc5xw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAP-5=fX3e4HRaLXxQhCwEHRuXZdpC0zEEh2pozEEegQBxgc5xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 4:09 PM, Ian Rogers wrote:
> Which mailing list is objecting to the frequent emails?
This is a policy that applies to all Linux kernel related mailing
lists. From Documentation/process/submitting-patches.rst: "Wait for a
minimum of one week before resubmitting or pinging reviewers - possibly
longer during busy times like merge windows."

Bart.

