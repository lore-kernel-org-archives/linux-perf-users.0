Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A7155CB0
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Nov 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178267; cv=none; b=GmRM6RQ2l8iinGFJfL9PuyNu2fyPw6Ky4gt+misgVXimSZveQfXvGWOd0RRrm3gij1CmK1A0CARUdIbTEUbBFEww5Fmx4aAk8FHczBTZGhmxS4Svrd6CYrkZd02Pvg/lurDoRqy0HmBIVFk8A470+Y8uXRB6k6SpzSKEOMlHFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178267; c=relaxed/simple;
	bh=cD4Fu3KbyxCyUuGjzEa4IuToSXO0RyJkQJKRw80eINU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZUQqYg0VaUC8vsocXOM2VZpaTqO77Lr0aAo466CbIfTeGBnyAqz68eSm20dfBAPe/VQhrSrFk2oVDYXmWw9KWEg5V9Q9t2noc3DjVB3feWMLGbWKaibGzIpO+XMqbpDF0K18fBI4nRMwMpKbUguJQjKoMVi33Pj8+8i5Qa1hLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyrmhKAY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyrmhKAY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732178265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/bxOafOSRqeGDMIei40eQfZmBrNqEM9xnfr1EgoXyM=;
	b=NyrmhKAYuLH8lTsHBZUtueyclZB60iQAvebYbNAqU12bTE6KH4ToJB6f0Ck/bbUgR12SNO
	McO9wGrDVIzb80ab2QKiabkTYFt4iqJ2KjMhfcmuVTy3EV5b3KErI53g2cQqKtC2agi5nb
	B2MOf1tH87lakMOBnzM1jhbhPjkr7RQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-HdyEyGECPU2YejLbUiDW3w-1; Thu, 21 Nov 2024 03:37:43 -0500
X-MC-Unique: HdyEyGECPU2YejLbUiDW3w-1
X-Mimecast-MFC-AGG-ID: HdyEyGECPU2YejLbUiDW3w
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38244684ccaso310678f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Nov 2024 00:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178263; x=1732783063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/bxOafOSRqeGDMIei40eQfZmBrNqEM9xnfr1EgoXyM=;
        b=PemXDrZUEoXPUyIg3TpJIsv1NZpOx802lRrUD2JsR6BlM9V3g6BBBUPLu/74rgLNv5
         B6x814LuBfF1+cNPbIMoPVKZrJVDkG0XzbKWyIcJPjTwFFH9CJVS9aJyGV6HRNb5ZyHi
         iHQv7JjpenIvw5hBQWhg/Q9Y5n2WFtKX8hIHxcY83eDlHvaCDPnfjd230KPdjytsegRA
         +IL5bMP03h2KZXr57G6fht8T89UYdrJ4Lcz8CsO5gdWzDp5/uYqT+jw/Jun+wb1HuWQR
         q0Bpbbt3TPZDekeOdo6lQG0ygT04C2Ch8VI1xYX+p+rkcQ+ZJrVZVbLNV2AB7N7UEGBH
         keTA==
X-Forwarded-Encrypted: i=1; AJvYcCVfYkHd1LHH74Pqnh7fQxmSuMyVYvFZKfKWv6ueDyYnbiHDDoywkcQDRoGvB0vi2RATdQuZYGbOq9BEwhpCur0v@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlq1o57VnFAGudBXjvH7M+AMHOIf9VXEA9HhucRfhqPg9JXa7
	xLjMeh93xvr1YFAVnxiHwK58lDNnvtzr0DDcJLUwU0ZqR0Ys5Xnt1qlVvu0yya/znvnDMYwQ4k5
	ctJ0+qZIaH7DW9OE+pahW2Z1IGmayGf06x+gdK6GUyyUR64qWWXCXLotrgySoRw9Nmls=
X-Gm-Gg: ASbGncv5XgAcQ9iJ/eLzBjdQh6pOEZ21+nryUR6SaX2iVvD6GsL1463kIxb/utnOCEX
	688IQKamnlWuRfGX6lzxWTRCdIJNyWMjg5Cyh5Xk9ACKyHHxfbEU0vqT2eFBtpZRsiC3QqMXKBF
	AFaNxeS3c+O6lHJX+SahwDo01CtGIZPcIvRhBAhARmSa7Ocsihl1xjkJ6/fJuflRl5yuNem2Skc
	w3TwdzPGJoDN6+MLc2dNOJLvF6stqM3fxY0ET7e+YvwcghscHTcCOznP4WKb0p1tt8JrS4L7Q==
X-Received: by 2002:a5d:598f:0:b0:382:415e:a144 with SMTP id ffacd0b85a97d-38254a83376mr4518900f8f.0.1732178262778;
        Thu, 21 Nov 2024 00:37:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwhkitcAujwGpzsyn2UlIRtZ04mvp+DvbIZs8ciCgtCb6aWVOCkAcYbsRMTziLn3rq2vc0jg==
X-Received: by 2002:a5d:598f:0:b0:382:415e:a144 with SMTP id ffacd0b85a97d-38254a83376mr4518886f8f.0.1732178262430;
        Thu, 21 Nov 2024 00:37:42 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493f3ebsm4208546f8f.105.2024.11.21.00.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:37:42 -0800 (PST)
Message-ID: <3646cb4f-4eb5-406d-9ea1-a407c3e03d45@redhat.com>
Date: Thu, 21 Nov 2024 09:37:40 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: openvswitch: convert
 call_rcu(dp_meter_instance_free_rcu) to kvfree_rcu()
To: Ran Xiaokai <ranxiaokai627@163.com>, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
 pshelar@ovn.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
 linux-perf-users@vger.kernel.org, netdev@vger.kernel.org, dev@openvswitch.org
References: <20241120064716.3361211-1-ranxiaokai627@163.com>
 <20241120064716.3361211-4-ranxiaokai627@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120064716.3361211-4-ranxiaokai627@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 07:47, Ran Xiaokai wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> The rcu callback dp_meter_instance_free_rcu() simply calls kvfree().
> It's better to directly call kvfree_rcu().
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Since the patches in this series are independent one from each other,
please break the series on a per subsystem basis. The patch 3 & 4 should
target the net-next tree. It will simplify maintainers life (and yours).

Also please note:

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle








