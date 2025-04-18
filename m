Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F52749D7;
	Fri, 18 Apr 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744981723; cv=none; b=l/4BiNZO/XzVLbldQVcLG/2mTurPv0CN+F9HX+NdMERvcfXTGVzsPpvWRLinyaKjcYkPKvyxLyvFIPu70Qa4imbw85ilhnYDyCVeVKIWh3pScntulZGMr2VEfbmBf0ik+pT+z2w9hxFm6nfp5D9cWIAO/mrwbgU4HiXbXstR2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744981723; c=relaxed/simple;
	bh=ZD4cNlSOLZMquN8qyLb4pwWdMwFPd6qAnJFhtRCch5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CqElGsJRDtiF6Zebbgo7d7foXYgBDhUmvc9RUHvq+UGv2oGAU0weYuzPI7AkFayOedJJZYsD+wRuV41jd3pchs1/it9jwQAQmk10nZXz5R5rHa3bzf0dL0wFqFklLpA8vy/cStxWDaftpbUCSmnv3tGlswIg/xExMQ1HWOGvRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B07ULLe8; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B07ULLe8"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7394945d37eso1516722b3a.3;
        Fri, 18 Apr 2025 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744981720; x=1745586520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O16WL3SgxPZ8win8gZA+6xubYI6PuCGAan8u2mItuww=;
        b=B07ULLe8ucI7gRWCmxuBWsbkSEhnmipsaXzf1yoB1RJyWHy6d8apUmqKp2fYKwLiqW
         DO+lXdcqzb+STP1DRkauDif9wxxE6JeJhLih73Wouz9z6ScVLy3Ouj/P+EGSwp3GvebY
         INpRC1DFYGiOR/r9MQwW1tWIKHbre4cdYZFYHLlPWWdYlApP7xLim9D5Wg9gTLsNV+hk
         NrSxZ4U0tB+SnYpJ/PQF9CYtpRFJOQffwyHfNh/fLZS0hJAOTMVfr7y8j14QR332cOny
         GVbHSSpahz/UzPY2VTsZaq8vAjQWvov7Nq8jfgKRdr5i8/1/ZMQjJpDvBYg0RzE9CvZs
         PGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744981720; x=1745586520;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O16WL3SgxPZ8win8gZA+6xubYI6PuCGAan8u2mItuww=;
        b=bZG8FQxyW10Qb+R8blXLxFocykXLB2SrOXNMiQUTQD2bUWr5JMVUek7Ys65idNOWm9
         /ImDA0I+RRXBtgYZAYHSmvMuKsjuzhSSQ44CuvZB4M0CpAQRRh7ItGKdJXRILqSbKm2d
         dUZ2WagM3WMyPJOKlC2K6pizCUpxcOi5h46qOX4s5H4oFkCvMfgHANp6ePeXUXPryJst
         EmCJjfxKTma+JSObxCWfVIsrkNdrdQOJ99vskP5XIFowNWXsXgmhjuy1HNx4okLa6V66
         jrmrCM4wExl1a4IAH2qObleDf55w5e6YsbuPB2fQVIcx2z95bl9jgHt+JLE5RSfI5SGh
         reJA==
X-Forwarded-Encrypted: i=1; AJvYcCVHAVPZJ6hrqbX2FmFe4kmP/ybiOLD05SQWiR8avoXTO/v3yLbMciy7LXsu/7Y0aRQYzFO7s6Kwe7EAf4Q=@vger.kernel.org, AJvYcCXKgDpa/JonZ2wwmyNQTo6MypqWtNeUKmDZwQZCpg+hzVri9ZF3uCJ5GlY8urssykNMInCgm0y0Rq0XV33T/sBRWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4FcDaPlMUP9Nb4Nvz4loH8h5GxCdu07LuKfQVtZNGKlCn6Xtc
	XwlZFeZB0PnJoI0lBH7BC8zuqh4U//E1PwNYb5Qew1iigfldyvV7
X-Gm-Gg: ASbGncv9bp3872hkhMphdpYkYoF6jF8R0YR9BHqNg1g0pmDBEKIqSIhx18eES2EeEMa
	DYMwxD+gLbyGwr8KuUTsUKO+xdUVcG/x0/gBCaWLc9IbPizVTnb941HIQYMJ/xsDrATjkjodpbT
	IeB/s/H+f539xqGUMHIqmHDmHz1jOq3FeklqZrtpXl3rrnlR5ZH3ViqdcLqlZdFoYZH9iClPAz7
	3Cnln3nQSswDjtaaK1r6+nQVErN535Ih7QCXxMGB91M1+fSpivqhR2SuJiilys8q96H7jCyhEBG
	HCo07FKD8F8HFQrdEKZ3RQqwEfh2USDCT7vhkXZKykG7++ypS+DahhjzDJQr
X-Google-Smtp-Source: AGHT+IFizGLmDbLdaqHB2YwDJuhvCQ/AMS2mdEAnW8dELZz86oyPH1OXYPLMPTUGlLNKPwdZeoabvQ==
X-Received: by 2002:a05:6a00:2985:b0:736:64b7:f104 with SMTP id d2e1a72fcca58-73dc1444626mr3452824b3a.5.1744981720523;
        Fri, 18 Apr 2025 06:08:40 -0700 (PDT)
Received: from [192.168.3.3] ([27.38.215.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8c0228sm1510925b3a.25.2025.04.18.06.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 06:08:40 -0700 (PDT)
Message-ID: <ca94f413-4e35-41fd-9554-c80d6e2707ac@gmail.com>
Date: Fri, 18 Apr 2025 21:08:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/core: Fix broken throttling when
 max_samples_per_tick=1
To: Peter Zijlstra <peterz@infradead.org>
References: <20250405141635.243786-1-wangqing7171@gmail.com>
 <20250405141635.243786-3-wangqing7171@gmail.com>
 <20250418090302.GO38216@noisy.programming.kicks-ass.net>
From: Qing Wang <wangqing7171@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org,
 kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 namhyung@kernel.org
In-Reply-To: <20250418090302.GO38216@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you very much for your review. Do you need me to reorganize the 
patch and send it out? Because if only the second patch is accepted, its 
context won't match the current mainline code.

On 4/18/2025 5:03 PM, Peter Zijlstra wrote:
> Fair enough I suppose. I'll make this apply without that revert -- it
> seems pointless to have that in between.
