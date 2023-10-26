Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6F381C4
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN/JyyZC"
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3A1198
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 10:11:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so1087343b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698340282; x=1698945082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDSMKDkZO/xRFcXz7gG4Aa42DMGO2mQFdu5QT59ZS7E=;
        b=lN/JyyZC8OAcZK8l2CHa96qPaY3vitwlk5b/k7E11MY1+Vk1hYd6AtA1KLXY2sKGkq
         dpNwM0hlLqQ6yFVlgjkrmr/TeKiwBWnlRo4upcVNUp4YXmgLoyFYm9rs4zlgj1TdiJRl
         5TL92pN0eL5/ysM/vERXi+w/UnHzfDsz+IcJCrm/MYB08X2iyff+cBnP5JkQCoe/c+a0
         AMtHOykB2jvhZy8c4gj+IXyNvgARDtyaRMYajLDMakwOn0C6i/OSHZx21rC+AEUvzqQK
         b59WFfyS2gpVaUErc5a7q5hmGO/oeOG4uH56nYrOm0b2DTYv1beEvAJZ3gg/qnYBEJJN
         GyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340282; x=1698945082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bDSMKDkZO/xRFcXz7gG4Aa42DMGO2mQFdu5QT59ZS7E=;
        b=AlrIK6i/kGd7iuhIF/4G+t22EsLfI41VH5j3gCw85d+8EQFtD/SWWm7D/EjI00+3rU
         hhKFixLGGEWb/QZhpfo9pR1aexF6jy/ywXNvie21eeIohlJLHAhWwCaUqhni5p0+9UkG
         8RMk3P19XsOBG2F5hrgCu1cwf8T6Xk+I/0U9lqOdF8ibJ0ytIxLIFBGjvBIYuEV29O5N
         Bh7hVlYthSHIhcvirwxsGQaOiqJBHjfoQt5fh0pwX0PW+q/FXbMt+x0EyWmsm0e8g4QH
         qMpABylvSSVb690Xz52QJm3oO9nOxzaxvporuDdt0XR+QETV2dB+dO/s3dw6U4vfiOmI
         KD3w==
X-Gm-Message-State: AOJu0Ywis5hH9K00HBW+R/ezPoYmeyjGAUJrSJn4scwGb4De7sMb7Os7
	Lqx+seDAMM72gZD/K+dnBwQj2S6d1T8=
X-Google-Smtp-Source: AGHT+IFbIp1ue27kqwObsBpXumi55FTvUNvXtZ5f8nwTtW+vIdeiqsUpOirwoK7od2NsNawXNtGFLg==
X-Received: by 2002:a05:6a00:22c5:b0:6b2:5d32:58c with SMTP id f5-20020a056a0022c500b006b25d32058cmr88908pfj.22.1698340282412;
        Thu, 26 Oct 2023 10:11:22 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ec51:cb82:a169:2ada])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7998f000000b00688965c5227sm11356315pfh.120.2023.10.26.10.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:11:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	Michael Petlan <mpetlan@redhat.com>
Cc: carsten.haitzler@arm.com,
	vmolnaro@redhat.com
Subject: Re: [PATCH] perf test: Skip CoreSight tests if cs_etm// event is not available
Date: Thu, 26 Oct 2023 10:11:10 -0700
Message-ID: <169833996382.1181734.821292465410589386.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231019091137.22525-1-mpetlan@redhat.com>
References: <20231019091137.22525-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Oct 2023 11:11:37 +0200, Michael Petlan wrote:
> CoreSight might be not available, in such case, skip the tests.
> 
> 

Applied to perf-tools-next, thanks!
