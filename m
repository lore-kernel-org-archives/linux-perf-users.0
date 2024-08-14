Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE271B3F20
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650128; cv=none; b=BGarBmktlNUyLOGgziqdhLgig/l+AZB9kbp7V3L+QiDIFzPG6R54i8px0k8eLTTWpU35tgCV/e49BzTvbO2bL8zWvjH9hgYGYZiZzkMtEcYoRX5A6qOKEHL2IfrkktwFpZhq65fbCrhcBU4Ip58Ila3avSh3Ag4d5OoO6KdvagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650128; c=relaxed/simple;
	bh=a/wXJxs07pRCUoT9ex+R1+vsO/FL/zYgpzeGt90Llc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5CPj8LbanC/ImyoOEL9K1/jMy8rF7nHvkS4xVjXZAyQWeWd7Z+2s2SRzJZbwVtHRxGm2DT1T46e8IdH5fPRmEx6UC3DTe8gVtbBtoLKuHB9v4KJrVlPNtfG19KXbKsUSARxBVzyHlVnIWocSLXsteSmYsz0/YKXSISOmV4Ogzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvUGUJpm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvUGUJpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723650126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVqUn5RuNBGovoe0fNS872jmo5+7uTt0EKfzWO/VE0I=;
	b=DvUGUJpmHvdMminh00Dr3CTrfjukztK3W6hdDxGZLbmGkcuX3pZXXsY4Wfvs4Qi/0QTV3m
	iZeyVDLOlpSHWHJrY05RB7zQ4/7EalW3dZb4DGDXOxHBLkdg7YOi0aprwu2UPZTktfd3hK
	9NENvmBePOHdopgpMmvkVapI29O997s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-3lTpfjHkP1yh347po38NHw-1; Wed, 14 Aug 2024 11:42:04 -0400
X-MC-Unique: 3lTpfjHkP1yh347po38NHw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f1752568cfso202021fa.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 08:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650123; x=1724254923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVqUn5RuNBGovoe0fNS872jmo5+7uTt0EKfzWO/VE0I=;
        b=Sdi+e8003Vbsp1xeL2Wzd2uMDIEl2RwJnAiANjLztxlLidg9TMbs+uzHl8bfE4FwN+
         4UVgZr2lL9TD0AqE4Kr+BQ71Y+0K37PchCsz2xq1mfSaOVF1YdMxqpXSldWRwWYZOVub
         vnwnvWLtcXM+Sd47vMV0DDCl1DlmUlEp5jqMDsBgvxswm/aiZ1qZy+jmNJHr3lwEyCVv
         nMyyIwvvwv3vd5u5wYFLWbHVY6iQHBC2vDDArO0PvfhGDQiR2czXky3EjRfsDAJXFL9J
         FqQuoOKJPSaE28icu4gW2aKi7IE+DpuY15qwrecUYb9LQ/9K9as/6cmDMc/ZBU+xKvwb
         24Nw==
X-Gm-Message-State: AOJu0YwT9KOwUlKFRsFt/XRdGtUByAK9SMf8o6P8PIgFiWV3sU74ttxT
	mElB/z+J8nXc3L1yRbpgXFcpaDCBFFKlNAEd2Zroluz89Hd4vI3HJi38w/vKjmg8+f8AHcs/6M1
	4/A41LSz88ZBYH4A+XYgo2+Fns++FH1lDaMRCDvu/Z+gZkTXoAjfTyPcGH2nmpzG30cI=
X-Received: by 2002:a05:651c:2126:b0:2f3:b17f:729a with SMTP id 38308e7fff4ca-2f3b17f7325mr8301541fa.6.1723650123117;
        Wed, 14 Aug 2024 08:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9Sxx0i06vMIO9QwZq16usHGJWO5uNYdugmvTtGCoN/DY42ruzvQUI1bAB3KtAMS52hFxC4w==
X-Received: by 2002:a05:651c:2126:b0:2f3:b17f:729a with SMTP id 38308e7fff4ca-2f3b17f7325mr8301251fa.6.1723650122257;
        Wed, 14 Aug 2024 08:42:02 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7dae0sm23472175e9.44.2024.08.14.08.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 08:42:01 -0700 (PDT)
Message-ID: <d847f760-896e-4bdf-9f8c-933f52a5aed8@redhat.com>
Date: Wed, 14 Aug 2024 17:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf test record.sh: Raise limit of open file
 descriptors
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com,
 adrian.hunter@intel.com, atrajeev@linux.vnet.ibm.com, irogers@google.com,
 jolsa@kernel.org, kjain@linux.ibm.com, mpetlan@redhat.com,
 rstoyano@redhat.com
References: <20240814151734.15409-1-vmolnaro@redhat.com> <ZrzOFDmwl9Z8F8NP@x1>
 <ZrzO2T1s_tIpqizG@x1>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZrzO2T1s_tIpqizG@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/24 17:35, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 14, 2024 at 12:32:39PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Wed, Aug 14, 2024 at 05:17:34PM +0200, vmolnaro@redhat.com wrote:
>>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>
>> Ok? I'm applying it with this change. Thanks,
> 
> So I added this to the log message:
> 
> Committer notes:
> 
> Instead of disabling ShellCheck warnings all the uses of 'uname -n',
> i.e. those:
> 
>   In tests/shell/record.sh line 35:
>   default_fd_limit=$(ulimit -Sn)
>                             ^-^ SC3045 (warning): In POSIX sh, ulimit -S is undefined.
> 
> We can just switch from using '/bin/sh' to '/bin/bash' for this test, as
> bash _has_ 'ulimit -n', so ShellCheck will not emit that warning.
> 
> There are dozens of 'perf test' shell tests that do just that,
> '/bin/bash' is a reasonable expectation for those tests.
> 
> ----------------------------------------------------------
> 
> Please let me know if you find any issues with this course of action,
> 
> Thanks,
> 
> - Arnaldo
> 
If so then the check whether the ulimit is supported doesn't need to be done
as bash is given as a requirement. Thought that it should be supporting all
possible shells, even though couldn't find shell not supporting 'ulimit -Sn'.

Can I send a quick fix that just changes to the '/bin/bash' so that the code
won't have unnecessary code?

Thanks,
Veronika

