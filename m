Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778E1F60A
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Jun 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360795; cv=none; b=dagFZjUZj2Gj7hu5h7SLjopq5zO+5qX8bcdyuwM7M4DMbWXA2vOw3mJEguWFzYGKH19tYCULJYEQv1jDUn/rhaOzohrzPidhzXSyRSps9NsLiEGnb+LsgRhYGQbsoUkNxjlkYEngBXVN1uAAUelx0OSNB8uAlJmrKHw/cpeldUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360795; c=relaxed/simple;
	bh=oCD7Xok56uSrBOhqqQ/8Y3CjOMlJGTG4v9+1o2au5m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7D40Mc8OENAcjHvRSdERCehL0au2gR3vPowLu5drOs4LsG0Mt5271nIsIUb0k1YLfabpyMsLK0XfzsEUaO8cUT07b10hW6JUXiXqSE0zSq4vvZIifbogSZbusCI+JasyxnZxrRD5t5+N9cvM6RhmPNPXytcB8j4MWcIF60JRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHyHmMQU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHyHmMQU"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52965199234so4122182e87.2
        for <linux-perf-users@vger.kernel.org>; Sun, 02 Jun 2024 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717360792; x=1717965592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T52p4Pn8Iw0ljBbOw7leDCNcjx0TlIT5pY7e2Y3YAzI=;
        b=mHyHmMQUU60IQXcVOpm5SagXlk49HTNx5ZVvSqLIKpd5+h6ZCOtjxpkjCluiWUMsc3
         14cPHjdTmVqAObj1zJxQkKHpTGjKmYxmy6HOc6VLiUp/ofbfCwXf7iHL+TjYSSQOAVKG
         PPHdEveo5aNkLaRI3xJ7STK8cuYgL49M1LFuJozGELoeO6dpzfy2RTpMzfuljaK1OR64
         a4A55rFOLbu4CpsvDEBC6tNSBk7s7g63qtJUyTvSDHXiYWyVrxhLOYp5W0VS97cSmyBo
         gICvgjYzfBC579xl6T1eKXoCtsCZgCQ1vYALM6J5aUHsYMo2qXy+tdLAdaZyEJiNL+C9
         BvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360792; x=1717965592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T52p4Pn8Iw0ljBbOw7leDCNcjx0TlIT5pY7e2Y3YAzI=;
        b=M/lTpZ86+M/MkHhOQU0yOJvNZoD7k3CsfPMwdsldwoCHn5QiscmMpTC4zDFks3gwQi
         TB9aPGW4kv+/+XD/1dGaXZtWOQl1eSTc+nxXJWzAsTOwXZFjltWoxqRLTtt29EhMtdfY
         9mdeSBTtbWVtn2+38H9fx16GvnsULPSwqJGf94FQdywx05FIvv+/d5IUhLUSlmt/cNc+
         q5nzz+z5U4yc6A2d+YvG7F1tb4ZjkCArlPXbGreNnxIYaX9kEUL2psvB8sBa9fB1Khjb
         Ky1SCkjmSP3yg9KCGY3KDWXO6nWowaufEQyi6rNXiHivJe/0aAZez6AnuwNCkuR34eWF
         u7YQ==
X-Gm-Message-State: AOJu0YyBB43IeOp569L5NzRPECJVbC8xrlaOvSZ/oPxyYWyAElQnvQ8O
	6u9MIrOQTQgyCauLl/i3aZb9EyOjdseRfO2nA4iUCz98ect0429owxL3weCd7w==
X-Google-Smtp-Source: AGHT+IEwc+0MkdbbHmcdiPaiwA0L1CjdfB5xGKlt8voRktXLdt+vU6HkYCl3N2Fw3v3szBfdAUf/Yw==
X-Received: by 2002:ac2:424c:0:b0:522:3817:6d4c with SMTP id 2adb3069b0e04-52b896f82cfmr4717051e87.68.1717360791393;
        Sun, 02 Jun 2024 13:39:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:138e:9906:1038:1841])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8736asm1034897e87.236.2024.06.02.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:39:50 -0700 (PDT)
Date: Sun, 2 Jun 2024 22:39:46 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com
Subject: Re: [PATCH v7 4/4] perf report: LLVM-based symbol listing
Message-ID: <ZlzYkpybqom9hvJx@google.com>
References: <20240526182212.544525-1-sesse@google.com>
 <20240526182212.544525-4-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526182212.544525-4-sesse@google.com>

On Sun, May 26, 2024 at 08:22:12PM +0200, Steinar H. Gunderson wrote:
> Similar to the previous LLVM patches, this allows symbol enumeration
> using LLVM instead of libbfd or libelf. This allows distro builds to
> reliably enumerate symbols in e.g. PE binaries as profiled with WINE.
> 
> A lot of the logic for e.g. length detection has been carried over
> from the libbfd code.

I'm dropping this patch; I don't need it myself, it hits some bugs, and
I don't have the resources to see it through. I'll send v8 of the rest
of the series soon.

/* Steinar */
