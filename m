Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95DA1F951
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Sep 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725188254; cv=none; b=Zvjd1ckp1oDX9ULVZZuDLF+auspxN+hIDVo7jAYpsfAGb3Zare8+7HhJ135qVTfRaule+Z2MW9M1Hic9Zpq6/Pg86bzblVnTGKHuZ8j69k0knXCtUdhWZbDmtNUxy+7xf5sYpI5ClVnUcSCVcWNfsCnPEy7bMmIjJgMO8p34JW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725188254; c=relaxed/simple;
	bh=1RX+vRj2WDBZgEHf/s25URGTZFaFeYvaeduaGZ5oaUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdbCh8DNbOs9j1EWZUUC2lIGyAqJ9KBcYLNWvesKCgC1S/37CQ0NXlrtJGaOzAX7DC6N8E/MbZ4J4KfzW688ri97furoJsWf9iCuJcaq3/NKqc6K8C6fypPhlZDV7f+4IOMpqamMI0JX3x6L+C3dpgLlUFdKYCXamsV6f+CfTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Asia66Kb; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Asia66Kb"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f4f2868621so34133251fa.0
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Sep 2024 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725188251; x=1725793051; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ECaoGYWyIBNbrv3AMXpRW3HLCAEHZsevcmAfdfVZ7K0=;
        b=Asia66KbDEWfbLt2LQSeZATiwdOXhCPCF94s0o3+T4Weef88GT/Wr+i9v4252eQSVQ
         vBC+HpLknOu8XoVavRqy39/5jjG2K2CnMmmqBJlbh6u257vJUvQhp4p5eP4h71eZykYx
         q08A8aYqK8CbOCiPjGUHnYezfdyEC73Vnz5cKiLxEhl7HZW7lUH6DPW/9qO/lLfMIOkz
         3j0s/EThqnX5I8tC65MKjVwGgcdJp4XkYgQcOr0h3m09xR613h4W7XvWogVvn37y8U4H
         cpO5sN+1IYvKMFZ/o3lz0pTyn/+gVweXJmZ6ZlwFIKK8e8Lg3OczL8UqxRtvL+3Kjus9
         L4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725188251; x=1725793051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECaoGYWyIBNbrv3AMXpRW3HLCAEHZsevcmAfdfVZ7K0=;
        b=Ivg84tO/hAGowHsRoSo5xIOcySFiaqw8ozeP/njNDMozVl/SiEYPZ3n/hhEI2MFl2L
         3MVqNIkiuWGwNYie3G322EYDRcnelikqz50z+SyqSbRpVh/VdM4n9xqv5kSWA5JmyTaM
         JjDFiuUBtS+DLyrW27a3YkKMcoI1G1Sh0zdLbnqx3UYrjRUM0GetUbJbBEPy69KZ2X/I
         NE9Rz+ToyD5AX373brvdwOnRoEM8t//rHgXWe5LWM43+aiq/U1I9zZDABPmn+woUPqeH
         xBMy7dSouKgQdXJ096n2mvQF2+NXEhJqHr5uXUW3dgQZUOl9Uqo/8DY3rjO8gFTes/ZS
         dR+Q==
X-Gm-Message-State: AOJu0YyEJwhL0MBZCK0tram6P7ZZiD0G3MbmJcAhXVFg7GzWcN+8TqoX
	Yhm3M1LWtipzUNMuBks02E5ph0QpWFJjQXIRFf1LPA4ukeScpMl6IroKNseRBb2bEzH0LtTw5Dq
	zYQ==
X-Google-Smtp-Source: AGHT+IHFmJuVRNjfjHOO+1xHeRCV2FbY7iA4y1QwPbq98Xs5aUU94MEEwJfZWZOVY07dN7YvGJCwbw==
X-Received: by 2002:a2e:4e19:0:b0:2f5:11f6:1b2c with SMTP id 38308e7fff4ca-2f629066565mr18624431fa.23.1725188250626;
        Sun, 01 Sep 2024 03:57:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:c40b:3968:38f9:d59b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f003b1sm13717311fa.33.2024.09.01.03.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 03:57:29 -0700 (PDT)
Date: Sun, 1 Sep 2024 12:57:25 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZtRIla5pCqlMIKvN@google.com>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqlDuIj_nMVXhYou@x1>

On Tue, Jul 30, 2024 at 04:49:12PM -0300, Arnaldo Carvalho de Melo wrote:
> Unfortunately it clashed with recent patches in the capstone related
> codebase, IIRC Athira's for powerpc data-type profiling.
> 
> […]
> 
> I'll continue processing other patched and eventually try to fix this if
> you're busy,

Hi,

Is there any movement in getting v10 merged? :-) I haven't heard back
since I sent out the rebase.

/* Steinar */
