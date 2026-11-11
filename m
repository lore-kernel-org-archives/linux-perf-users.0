Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405792;
	b=Vfompgcz0/TF9/22K/WJwboCrb/dvvnUL+6N+NUaNnvWRkkK5xSkYkYK8ZvJiJTN2rFy
	 0NX9p4Fs1wpkNdpkXSxK1okD+Lnim9/Vo/CqO/lGd/i5J9IU/kUjyNgajqw3z45ry11NY
	 hAkDlF+p1doa9jbM5GdPXnXRbnTX5zzNyHo2UcvOj/nC6ZvUpNJ80nYQV5Q6433QxIyeR
	 00gJkgqFxfTMkP+tJ75UuxE2k9Q9u2v67ZLr0sJMNOGrX2Q4yXpspDSDtW6aDx6I6my1+
	 Ivk2xAtTxDbPB0TjKwTWFDWLgWwu4ZuifieWRFVWp6YUC13x1cQwMNIeLXNnMV74DUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ib+B96G7+gmq0/izhy8Z5ZthzY6w8s611Ial48mm0F8=;
	b=y6k8KvwtxskLKPNQ37ya+xUkuhb3359bdebh2FHi+Oo7ONwCyifKwQO9Qi5A3OoN9Sh0
	 iIQo1vQXPSNl8gv6j3i2b4wiYqu73WvCHGM1ccNbjhkIHpxKskUkP2YxPvTnNPuMDC41q
	 Wr96/c4ozvtiAeZMkkhqj4wt3pIELI21Q6MZ7CFGhngjDwHAfFi2At+lM05iyus6/hegJ
	 pHTD+G7Vn0MtHeH+WhOEkQb7pw9gvK9cuaFIqnhr4QTne5qi4WcKcA74ynFbKh4snZBTk
	 K8OiIJVHLzYloqrtJnnONOoKdKmgxdy71M/fcQ/lMXQysvxMkP2X8EGcET9SUXMfgMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="x/mTHq+R";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A80606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 14:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A80606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=x/mTHq+R
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so40329485e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 06:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794405791; x=1795010591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ib+B96G7+gmq0/izhy8Z5ZthzY6w8s611Ial48mm0F8=;
        b=x/mTHq+RkdWSTT01DvKGgaenVoWNtEjmumDLdRb4peR9Lp7Dk9JNnzNDVoiBCITwUp
         WLNDwuPumOuAwK/Jp3Yhd/ODZh1IVuMLBzEJY300fsygNCaxclDNM91jbeYZH2N+TPXf
         aMFFjaZwTEPdo17BzcL//lBDMtTzuPr/4Xhghlh6T93L4SLjHKhczpumHuHVh+VdyvPg
         4/VctMkwL5nKcv6NR/UtueX3iMc7YmWCvSIfyBJEVRSzsBkmp0NKNtUe7DLmNeYXHlT0
         nJN3LwzwCwecVS462Ph6tuUax9aIEaCpvkyqzTuVsKx66dYyKUoavu/kikooMfQDZJZc
         9n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794405791; x=1795010591;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ib+B96G7+gmq0/izhy8Z5ZthzY6w8s611Ial48mm0F8=;
        b=S4GS1Lza7Ksr6ui+/kPyLD+Nca9gMaSREL0sr9rMPBKqO2qMwqoeMnxHHfFvmsvavQ
         83qa+Kq4GgThWUGSswoQ8eko8T3LVYHFpcxaul4eLWdurbg98f0T3a8Fs3uY5zCgp4ez
         vkKMY5mhzuJnJ2ppzUE9NUD64CxJ3SrSLO9G6SnbN//pXY/QNjCJvG2hwkOyJYV7g6H3
         Q/dwjHCWz0FnQqvmr60sg4e/aYi5ZqKf9ibgZT5E1YTE1xzzkhTeaFU1cz212K8xVgSd
         mLzKkTG7aJmL6c6JmJnIMBQYNrhlaeAZ9XkDsgnUmp7Ym3wf66nXvj78zQTqMEoz+o6p
         c4uQ==
X-Gm-Message-State: APuU4Z8J5nj0ZJ/BBRF2pGLvw/CSQ3ZYXLU747reeYWsk8MFUNSxDqm/
	k/jBFqaR5Drusak8lmXizyQv2MjbEuz+aluzq1MEwbpyvd8MHIqYyiq4INTSeBCGuAH70HLSMxh
	IgSykiQA=
X-Gm-Gg: AYBFou09sIqYu9WY/mC/x2X9DFlyNwBsaAptYgsJc6FsiVUEFyWY7UYOCR8FAEk5h8R
	GPkopc1qwAQQh6q3lmQrgPJeNlU7dxwlnZvrX0VJwAJtAK/04cRVBjSLkEYGito5UnZr60W8GPX
	oTz/4doLJ349a9YZPGR44/kjQ7sO4AIvjO1B8ezkvkVQKunfKpAmaLMLj9mvc5WPzE/Sj0BAXlf
	Aq4QLrfjMcGUCZPLKI9VhiQ/yfLtTh0irjvrt8syJGhxMEkknItyI/gRVzHMARIDcpvs0GiKkTz
	WNo0YomS1MWgEXEWh0h3ptIbiOw5lReowPgAAeuNm6jZQOOlis7ZNv+WMQAfGIxaR8sxdX1fbod
	V+u4J2pfWDq+3P7tEI7BlXSaa0A36rmLYcRPmQbepzVeL/IGd7bDC4wmUH+zyysBU0UvAZZDImA
	RKBu0XUnCxQPBE+pwEH5KzBHb0isOPfLDuqqM8mqF0yIpEzSmaKq6xPpYwnk41QjEWtjRYtIN9m
	Xq80dorY/6g8aFKxBFIfn9EqPxYZAY5BhZTwXWVPV6agsbfnc3W4IGeimmST4FtUyWDqqbmG5lO
	HsjD0IoEE2e7wItI7cVb+5fuAIYSU9abX0OHCGXLMQcTbrHOIwWif4c=
X-Received: by 2002:a05:600c:1549:b0:4a2:cbe:bebc with SMTP id 5b1f17b1804b1-4ba0938ba0amr45260745e9.23.1794405790819;
        Wed, 11 Nov 2026 06:03:10 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fba476sm172702635e9.2.2026.11.11.06.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 06:03:10 -0800 (PST)
Message-ID: <1e5907fc-40c6-4025-8d27-a92b3cb2845a@linaro.org>
Date: Wed, 11 Nov 2026 14:03:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Fix misspelled
 PublicDescription keys
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.garry@linux.dev>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261108183846.3804875-1-takano32@gmail.com>
 <bf6925f6-613f-4e20-8491-2a99183f34fb@linaro.org>
 <39ac224f-2903-496e-9a08-b4c5a33dc87f@linaro.org>
 <179440414898.2353714.11591904089911934138@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <179440414898.2353714.11591904089911934138@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/2026 13:35, TAKANO Mitsuhiro wrote:
> On 2026-11-11 10:16, James Clark wrote:
> 
>> IMO I would rather have something that's incredibly strict and simple,
>> or nothing at all. Having to work around edge cases and report near
>> misses doesn't sound great.
> 
> Agreed, and the near-miss report is gone.  The series is posted again:
> 
> https://lore.kernel.org/linux-perf-users/20261111132622.2349165-1-takano32@gmail.com/
> 
> The check is now a fixed list of the 51 keys a json object under arch/ may
> carry: 47 of them jevents.py reads, one more metric.py reads, and three are
> read by nothing although the tables hold them (Counter, CountersNumFixed,
> CountersNumGeneric).  A key outside that list is reported with the object
> that carries it.  There is no cut-off, no similarity and nothing that
> depends on what a run of the generator happened to read, so there is no
> edge case left to work around.
> 

The linked patches seem like a bigger change than what I'd expect. I'm 
not sure that's necessary for something conceptually as simple as 
"validate the json files".

I'm also a bit lost about the relationship between "[PATCH 0/3] perf 
jevents: Report the JSON keys that jevents.py never reads" and "[PATCH] 
perf jevents: Check the JSON keys that jevents.py never reads".


> It still runs as "make check-jevents" and as a perf test rather than as part
> of the build, and on the tree today it reports exactly the two misspellings
> we have, the 16 in this file and 3 in the AMD tables, so it wants those
> fixes in front of it or together with it.
> 
> The one thing I did not do is put the list in a json schema file, because
> perf's build would then require jsonschema, which it does not use today and
> which is not in every builder's python.  The list holds the same names that

It could run if it exists and skip if not. Or we could make it a 
requirement, but that would require some agreement. The docs builder 
already has a pip requirements.txt file.

Even without jsonschema I can't see why a validator can't be written in 
less than 10 lines.

> a schema with "additionalProperties": false would say.  If you would rather
> have the schema file and take the dependency, it is a small change from
> here.
> 

