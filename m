Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8327446
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550847; cv=none; b=ASnxTmbJTRgVVuW09RFq4H9jrjWW+igg7hUnHN7OgNUhjOC/xa3g6mQUQhkewTt/+jjeRwHVTJ2OVvf6ev00YKiSp0gm0t+GsE0ZlrjkZtZAJfqpyEcDtx1S8I01x2GupHhZ3yIDZ/HOCBgrsRRUf9IirdkG7LwjGLYXOrja2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550847; c=relaxed/simple;
	bh=64GymSvExgVvMNrrSC/SBelYlL0m/E5g24LZPGyj9e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u66wL18gnYGh3vQDznQfoIFRFIw7Q60ElpbGH/3g8+jMToxeYKOFMGNKzXfI0SiepfEa6ZXv15uW39bpVMlLQSpcRH1B8o9m13JkuwPlT9U3fI+It/5b7irJC30s1EJfC9oT44F7kE2LnGFY/bKNm50Svjz4DgTrTu596NX3DDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z3InYi2z; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3InYi2z"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53993564cb1so786109e87.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728550844; x=1729155644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6ZUbOP6vnOr8QwFFV3qZt5HFAnMj7EcqvRJRb+VMhk=;
        b=Z3InYi2zSIry7QhIMv3ulvkGctQ8QJ0O2zBbJO5hiN3kxWQfyXByPPvhLwDZ+Ke3G3
         sCVeTBCZ07bP8cV2W0eleT54iyQTm5XwtRq5FzBw/JZ03ywAst8Fvtuta+DTSxTsAus1
         0gqIXkRl+nMtKrgGXWF7w2MpjRiY7TpV6yBF0bLQG6UKCMToOqXQHbgu6s1oCOcFvKZf
         I5zRCxHrslh6wkLDh+rEXDgtQWoPbAbOrt2NZaEdx1M5Ng01zcehVckUzMqih5tJYmPY
         LkhVJ9bFfBfwyXKk23C7+9Zk/k5SEQ6dIZ1aOT7i7+PPkly+MfNEFVsCJn4GPQHlHWad
         NdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550844; x=1729155644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6ZUbOP6vnOr8QwFFV3qZt5HFAnMj7EcqvRJRb+VMhk=;
        b=fiPkV5kBJmaL8ieS6KYZp/YxKO2kIkm5ReqY23RYKKgad3I8vEnW4Ww75jh16H9vaQ
         0IXjJw29LyOoO70+31tQ5AiU/wNolFrfyqCZ/733Or5iMiUhqUgrERYtejldFRE/3OFm
         lTMVbYyv4Hm7xEsBvngKEDBCZjbQ65UVjTBPDRdIOc6aF9WYvfTQ5dtN475ZP6Ipdlkh
         P0yrE91oqhp2/2SHoC/y9JXUL5vsTKPKph8H4y6S7L92ytV4I0IKU86OZCJqxzWPDlnh
         VFKhIvt/DteRMp8slcbi02vsqnQ3XlmlxbQsNbCjK1z8TQIECT+LjykV4ZNge8ota1DJ
         E6sw==
X-Forwarded-Encrypted: i=1; AJvYcCX9RB72Kxlr/AEKpxoC8hUKZC8jGWEGB3xQIRSpdaeUOKAE9pFs4NEx6jneG4wPMUYXCFZ2LcAKhgZ20ked4hK8@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwS2xgNkICAC6Xnu5JAyaOb6pHXxgxp+dZZfHjN8d8PoHoPyY
	5Zk/sxE1DHqEWFQ7BdaqVzXHoePiMgUo8GCmZojb/YoB4OJnfO+hfbBQipzMl3HqPX1rpo2604+
	CqG4=
X-Google-Smtp-Source: AGHT+IEhYmdPXd92bozGQrprD0sAK40chJEpD7T9tbzKjLmQAmUi+aGlgtqHNb//yZcy9ovMlVedPw==
X-Received: by 2002:a05:6512:3da6:b0:52e:f2a6:8e1a with SMTP id 2adb3069b0e04-539c48ea908mr3653639e87.29.1728550843489;
        Thu, 10 Oct 2024 02:00:43 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7edea7sm906254f8f.93.2024.10.10.02.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:00:43 -0700 (PDT)
Message-ID: <bcf50648-3c7e-4513-8717-0d14492c53b9@linaro.org>
Date: Thu, 10 Oct 2024 10:00:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
References: <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org>
 <ZuL_0V5jgaaEUOY_@x1> <49fe18ff-827a-429b-9d74-9d8ed02ac409@linaro.org>
 <CA+JHD936J-q0-7LANQ3aW2G-PEmFP8PnXQ-TF-AMs9MtrCqfew@mail.gmail.com>
 <CAH0uvojUEXiT2mk1pknLS1nc-gA3Py+AjmEW22ETiCCyOLLr8Q@mail.gmail.com>
 <CAH0uvogXyYP1LqF3fbjZGHHDL6BFZ2ZKu5JAASnK_brgnymf0w@mail.gmail.com>
 <CAH0uvohEozKixjDM9_jJ5FFxYK7agsqVO-BrAsm=4hCTDQAx2A@mail.gmail.com>
 <9bbfe425-1f2b-4846-a5a3-a31618742e9a@oracle.com>
 <CAH0uvojJ1rME4hb6NfrA4NPj2XmGMDLOLP3wEbHh8B5-qWGvFQ@mail.gmail.com>
 <CAH0uvohW7_st0i=ek8rc_SucuQEQUgs+fWt12cc3jqiYfxAjmw@mail.gmail.com>
 <ZwcnVKn3wVSSMcaL@google.com>
 <CA+JHD93JgJL_4GJFcFUNu-FpNfFOoyDRJ7QuvO82M8G1EwM5pQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CA+JHD93JgJL_4GJFcFUNu-FpNfFOoyDRJ7QuvO82M8G1EwM5pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/10/2024 2:20 am, Arnaldo Carvalho de Melo wrote:
> On Wed, Oct 9, 2024, 10:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> 
>> On Tue, Oct 08, 2024 at 12:27:24AM -0700, Howard Chu wrote:
>>> Hi Alan, Arnaldo and James,
>>>
>>> This problem was solved in [PATCH 0/2] perf trace: Fix support for the
>>> new BPF feature in clang 12 (Link:
>>>
>> https://lore.kernel.org/linux-perf-users/20241007051414.2995674-1-howardchu95@gmail.com/T/#t
>> ),
>>> sorry I forgot to cc you two.
>>>
>>> Alan's thought was correct. Thank you so much! :)
>>
>> It'd be great if any of you can test this change.  Now I only have
>> machines with clang 16.
>>
> 
> I'll test this tomorrow.
> 
> - Arnaldo
> 
>>
>> Thanks,
>> Namhyung
>>
>>
> 

Tested with clang 15:

$ sudo perf trace -e write --max-events=100 -- echo hello

   0.000 ( 0.014 ms): echo/834165 write(fd: 1, buf: hello\10, count: 6) 

                                            =

Tested-by: James Clark <james.clark@linaro.org>


Unrelated to this change, I noticed that with older clangs or with 
BUILD_BPF_SKEL=0 that commit b257fac12f38 ("perf trace: Pretty print 
buffer data") changes the buffer address to print nothing, and the '6' 
return value is missing. Not sure if this was intended or not:

  $ sudo perf trace -e write --max-events=100 -- echo hello

Before:
      0.000 ( 0.009 ms): echo/772951 write(fd: 1, buf: 0x58c415257440,
         count: 6)                           = 6

After:
      0.000 ( 0.009 ms): echo/760370 write(fd: 1, buf: , count: 6) 

                                             =

Thanks
James
