Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642CB14F90
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVaoAR8K"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A013AB8
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 03:00:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c871a095ceso56272825ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697709656; x=1698314456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YveHEXWYdTMOMs8MUtnDVPlFMu9qzITMlzs8IVeDlII=;
        b=UVaoAR8K+I3f9t2Lhd3WeYChGXIAnJhnCd/Gl59zkx16QdB6jSwYDtXcGL42E3MIyV
         YJ5MdoWaeswZXgdDZTGrYCwV4vSnFHLUNYj4tdwq2Qb0oUSNjSbceEH+5JrVf6z2LaRN
         utAndGAF+D7jTxQ1GbTZKFTk3jVQh/TMlIy59eHSWmTxziyAprAYtLfICSI+M+POxnUh
         hG9ChRTnmaYsOLV0506GBOZ1h7jR+ro0lItSfkOsUWn+e5LiN1kjG3qpwvy7PkGRbyw4
         G2cKYmJV2cborzsiI7t8KjuuVu0yB6pTTyLxKhvWKLR9CRbrFpCOHZvGz8mJ44kNxEq3
         I3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697709656; x=1698314456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YveHEXWYdTMOMs8MUtnDVPlFMu9qzITMlzs8IVeDlII=;
        b=omCIjlbkGpbtl2CB5mRQGcwdWofEes5LOzbDkp9afrOZKBrX+GaThTqCaB3d9GrRr+
         fKxzKnR+IbXGQNBxKeYTRozjQ3uUUrfQLCQ1IreZC/ZcvctOk1GAYAUTXxmtgrshZ+mp
         5EEIV7Ttf+f6ezu2YYaevTakoCvTu9Yz2N1YskSjeZas/xuj5HrPK9E4/FI7KflknkFj
         Xsdx4ftMDuKEojjzmBgClU54dswmln6IUdkmrHitY8igTaDqz4NFmQVCY28Qe2QqW6qB
         eP2ufw/Yq/0b8K9qxpoG9tWYNPt/z/iuyv7VRJLfFxagROSL8MN3FftoHByH8nsygJFO
         S4OA==
X-Gm-Message-State: AOJu0YwH6PNPlU6/XKaXSRyoUmCSeP+/tLDMRNoDF/M27Zk5994diYrE
	g7/YVsIsV/FQKNoF8JvIs6b9C7bGwnqtzJfoPLkEpQ==
X-Google-Smtp-Source: AGHT+IEhV6HUURLUty0PrJMJOkODmK9swOXr6b5sBHs5rF6G8yp1bfZlVKyQ7ACEPlUyHCYrVCMc+g==
X-Received: by 2002:a17:902:ea08:b0:1ca:4ad7:6878 with SMTP id s8-20020a170902ea0800b001ca4ad76878mr2337695plg.8.1697709656058;
        Thu, 19 Oct 2023 03:00:56 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.160])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902740200b001c88f77a156sm1508799pll.153.2023.10.19.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:00:55 -0700 (PDT)
Date: Thu, 19 Oct 2023 18:00:51 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, vmolnaro@redhat.com,
	carsten.haitzler@arm.com
Subject: Re: [PATCH] perf test: Skip CoreSight tests if cs_etm// event is not
 available
Message-ID: <20231019100051.GB105208@leoy-huanghe.lan>
References: <20231019091137.22525-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019091137.22525-1-mpetlan@redhat.com>

On Thu, Oct 19, 2023 at 11:11:37AM +0200, Michael Petlan wrote:
> CoreSight might be not available, in such case, skip the tests.
> 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/tests/shell/lib/coresight.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
> index 6c3d34ec64d8..11ed2c25ed91 100644
> --- a/tools/perf/tests/shell/lib/coresight.sh
> +++ b/tools/perf/tests/shell/lib/coresight.sh
> @@ -10,20 +10,22 @@
>  
>  # perf record options for the perf tests to use
>  PERFRECMEM="-m ,16M"
>  PERFRECOPT="$PERFRECMEM -e cs_etm//u"
>  
>  TOOLS=$(dirname $0)
>  DIR="$TOOLS/$TEST"
>  BIN="$DIR/$TEST"
>  # If the test tool/binary does not exist and is executable then skip the test
>  if ! test -x "$BIN"; then exit 2; fi
> +# If CoreSight is not available, skip the test
> +perf list cs_etm | grep -q cs_etm || exit 2

Reviewed-by: Leo Yan <leo.yan@linaro.org>
