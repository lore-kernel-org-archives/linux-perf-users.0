Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB62ED879
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249330; cv=none; b=ivu9I8zdm8qzyj0grC4ZWjEFiwF05h5xlaZ6lKJz7eOASOQnFhCTZrDu6SdkhCjmB9g7UvWhgR0QhMfhQ/Fzf/XwI8QoNxS4+pWCUCBk25Usldb4+y6VPQmLjvxc+Wx1s3ONYqvkhTabQRt+i2w0A+XtgOm0IZuYc559ZP3BWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249330; c=relaxed/simple;
	bh=ZJmv2kGsngYQ0j91GkPhYp/ZYB34ERAIc1y7RI+IQLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBuXZxQxGUmtC96B5xTFEWKmXt4qskl+nrp/Usyl1i3Lox0IecNMAvW67Bfrz1HD7Hu5zeHyDDRGdjKwDNWgB5lI1UPSokDsgwvRZ9vDZXdRoeKSmVd2hcwJvASFOURhJIT8So4JIChGqCw15qSeRLs5J85cwdPQstxUI3bG1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hGfd1c3B; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGfd1c3B"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so2570165a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2025 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752249328; x=1752854128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSUEvMdfd3OtQjcJtnT8MNHYb+tPfeWYuWYxCvun5Ec=;
        b=hGfd1c3Bmfs+N0Q6OIahJD/ljkhLyGSm5/VGuW7O7gWMM5pH9pt3Ez+dI1bRb4YxW+
         n5v+S44yuDC7Kf7cTgmJB3Lvl8mPPJgZyCe4P2GtZRgWMzHo6g9fOc1M/fhbo2v0mYKr
         2WdMC98Sy6TuWBe0mFGqj8HmVg/3LugMc+NZmOSggcb8kk1vaIE8G66+1e/c/izjec4f
         QtYd+vkEzmnTJTcJV0AwCqCWv4Z6BaHLpvNAf0Sb8DWxHCm6l1yD2QWDGd7HPje2Qffw
         CAB/y2uox31k7/3FAyMiOh9Sh5w0AORpHsQddsO1/q+pYLs6lEZhhaxrK7xeF9AIZB6s
         4L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249328; x=1752854128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSUEvMdfd3OtQjcJtnT8MNHYb+tPfeWYuWYxCvun5Ec=;
        b=YfAV5ItEx/d7u+mqJTpI5mlX5TtIj+4gOg67tcHhci6KIlYxv7kcPdSWygVRNvBgqD
         BimcLrVXSQqF0wCrZ0COQXs0Swl+P0Jz8aCEPqtvH7/gy6W2yc5VxfpFub/BDfkc5ZQm
         79GotWLS0O9UgweRZlcG+enfbgQRkmyFixIvrG7a3RnwWCEdknlR2mZ86iharMPoEKAG
         xffvnMsoFq+gWiQlAnaKJVCFddGq0oLPcSIHPlc4XvFNryrATI/pdUOEH2Pt0D4lmUlp
         blMGjTJQjvk84R+HiHCvcF4PO2b8wRnQyVLfRQ+v5C8KH7LDo01ZJtyxygWhspjqIWiS
         jsrA==
X-Forwarded-Encrypted: i=1; AJvYcCVvaLR7csp32H/m6QuRPKfp36tSMuilOyLozvpWEH26oo7abcnPXIFrQNAiBs4xxSiP1BWdta9C4gRpYdzq9+nH@vger.kernel.org
X-Gm-Message-State: AOJu0YxPMnQGHX5dn9GM+n0dSo66xbQEfyE0W7UNnPFknW69vnm62YTS
	NRCxzje15ySvgtDpuVtkkwT4IPlP3pyNWdyS0NQ4BtV9TQPGAaxW4E7sW38cLqQsDgLgGiGsBEr
	jfz88fS3ynZVFjfId6IWkW7eYwyA5cIwQw8Q7cGyUXw==
X-Gm-Gg: ASbGncvRH5goq4f7jXtRla/fwBwA5mV0/jkib5BsiYNvi2rb1eVVSmbMzEBa4BGXrUP
	AOarQuU6JO5Jijf52+kUAMwQZSVa6p6i4YwTs7A8WNK6+lnP3r+XMdmotnzrS21iCXLLyG+JKyi
	jTz12eK8/2Y7SlFkKOhB/gPAX7LiHes3I8PbQopOQyOGLFJgFR9/XP3yVcdnX5KKC2ZNX/wsc5p
	UvShe71/MTsB0lgAcGcJuaGhZrzkVmMzgOalSde
X-Google-Smtp-Source: AGHT+IH2f1kHKtkhmbSDnFwU9FsRvu0+CvMkmIgA/3wZF988KeEXY1isz3v5NjcaxVFtljjYa3Rl3Y2Bu4pS6enpzQo=
X-Received: by 2002:a05:6a20:244a:b0:230:f847:6586 with SMTP id
 adf61e73a8af0-2311f4315fcmr6577705637.29.1752249327964; Fri, 11 Jul 2025
 08:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708151502.561-1-alireza.sanaee@huawei.com> <20250708151502.561-4-alireza.sanaee@huawei.com>
In-Reply-To: <20250708151502.561-4-alireza.sanaee@huawei.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 11 Jul 2025 16:55:15 +0100
X-Gm-Features: Ac12FXy6OFHr0HcNSbuwxmKfYiD99i1dpKvfe3JL9VMIP9NGMICwwAp3JOTw9ag
Message-ID: <CAJ9a7VhfW2RYXv6ZO28m65C75iyJUqTYos1tFXs8gAG5gx9yDA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] coresight: cti: Use of_cpu_phandle_to_id for
 grabbing CPU id
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: krzk@kernel.org, robh@kernel.org, coresight@lists.linaro.org, 
	devicetree@vger.kernel.org, dianders@chromium.org, james.clark@linaro.org, 
	jonathan.cameron@huawei.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linuxarm@huawei.com, mark.rutland@arm.com, ruanjinjie@huawei.com, 
	saravanak@google.com, shameerali.kolothum.thodi@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 8 Jul 2025 at 16:16, Alireza Sanaee <alireza.sanaee@huawei.com> wrote:
>
> Use the newly created API to grab CPU id.
>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  .../hwtracing/coresight/coresight-cti-platform.c   | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index d0ae10bf6128..e1dc559d54aa 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -41,20 +41,8 @@
>   */
>  static int of_cti_get_cpu_at_node(const struct device_node *node)
>  {
> -       int cpu;
> -       struct device_node *dn;
> +       int cpu = of_cpu_phandle_to_id(node, NULL, 0);
>
> -       if (node == NULL)
> -               return -1;
> -
> -       dn = of_parse_phandle(node, "cpu", 0);
> -       /* CTI affinity defaults to no cpu */
> -       if (!dn)
> -               return -1;
> -       cpu = of_cpu_node_to_id(dn);
> -       of_node_put(dn);
> -
> -       /* No Affinity  if no cpu nodes are found */

Leave the above comment in place.

>         return (cpu < 0) ? -1 : cpu;
>  }
>
> --
> 2.43.0
>

With that

Reviewed-by: Mike Leach <mike.leach@linro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
