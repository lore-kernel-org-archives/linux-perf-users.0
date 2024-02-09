Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F383A5F
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707440941; cv=none; b=nVYq6kRxdFrmvrvxJ0xP0Yci/Xc/83YRUAhmgYB98j1nInusWyTTS+bhHlaUVKtlqb+GTu7TCFJsw88SWat0xiVXIL3SkpMrDsMacsJPua2n7voT7PgqoHLJ6m89MpVuJhlkYb3Ivifutxhb2aBJ7jEcTAK73YkKozoIOyLap+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707440941; c=relaxed/simple;
	bh=saf71vwQndOlQdrTEDhk9SkGh7j19AzCD2D4+t42tlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoQtYUhzU/gw/lA++mhnz5iufcdYbnKZB/TlV6yXPzH3ViDhbKT2NFUJ1J3e3s0C3bvnBX0oLbgnzKmag0xZt9xCHmVV0zeqRLyn/Dg/OOQr38GWSzhysT4AwX4lK6N0XugO3Nl7WyWOk5lwYsfTaYR/NHcVwR7Y8KuPP4G0H5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q7ugFWl2; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7ugFWl2"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bda4bd14e2so282494b6e.2
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Feb 2024 17:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707440939; x=1708045739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynqon4qbYB4mxnwL/nvoALPAgdStE0cjwifhpUYnl0I=;
        b=q7ugFWl2b8iQkw9IEalrdY5F2xgE249hza6N+BIV2/opYb29J/K7QYTT26Q9dJMSCz
         ztOcZJ3TsnOehtr92os7whXbCTrsQmJd2kQJM15x9kMbKDghFNALXqXu3ivh9a4vUl9A
         681peJwqp9cjVKkjv6SYbf2eTYjoGYwxDVkWmwV2lIUsA58vYqzQF7NM4630bN7wdy6k
         VboF/38LO6bgbBDP+69fVeggfkTGwvDSWcQ5r/BU46fUiSb+Sjd5Lr6xsCEWOhkgS/lH
         kQnmnoRHzUpNqt+aW9DOIYdiQWPDqF3DZwRhijuEgo1c3n9yX7z1w/2zJxleD/VZE2dv
         Bs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707440939; x=1708045739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynqon4qbYB4mxnwL/nvoALPAgdStE0cjwifhpUYnl0I=;
        b=jgq/1BkzBt2hclwFQSXuu9doueZDPCJr0r1VFwaOqphtQ72z6dDu+1g3y4tmrg/5KK
         bRz77KMoPP3snA1fLtxxWj5mGBaiHS4+XmWUbaqHdwvvUtK2ELJBvk46+qzON/sKmX9t
         +uIZ55kvzlAgyJYkEfFrnv32rh6I00rYcaFz12Jni2x8V1fQ56PCxzuMMFZU0lp6Y9/r
         6RAvjHnWLKJrv5hSAtQoH+EopH+RXhyIXb1DXtPL8w7sI89BZi+DJVKw947/aSo9D/6H
         jcj0M+mmcPvB6TZZCOnFN5GA/ThPceeo59+vpPFm9mAgchwwq/WhbSakJt2OeMIuFoVS
         ko+A==
X-Gm-Message-State: AOJu0YwOU+1+ZOM5f0TK66tglhErWWlBU8ALbq8pCsnuQpP+72nrLfd/
	C6OZA8URbiatz/E5ExlLjlK5A2oijgxr2ZW59mVz5GQDsMKsKkXfKWpZnBc+19s=
X-Google-Smtp-Source: AGHT+IE+ydeAjKazZqlIUkcg6OFOKljI3hySZBmMxmoschfsmspRgqdXtl3NOSxDwhzpCvSwU+2C1w==
X-Received: by 2002:a05:6808:143:b0:3bf:efd2:bab4 with SMTP id h3-20020a056808014300b003bfefd2bab4mr213261oie.26.1707440939018;
        Thu, 08 Feb 2024 17:08:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhNZXqd+orOyXeecff3f0uNuuLwNTo0tAxtTSiAbAuk0QoLygsydGfmJBt+B6rNlpqbUCu0p6FxiEOs2BKvckTyFSpoMeyI3IAw7yIZW1ZRC2jb9+eiMIXcroN2wMDuoGiItW6eeKfTd5/G6Mt2VXz0nOcjSUgnPxvyNqjr5SIfSK590DkJTUYFdSeYEKa8rM54IWSznbZVExMqMTYZ4HU1lMeJMzW7oQ2pYWypiJm/IYJEPEkGpm5a6MGYjm1SNfBOe3RVavTonfK0ap7u8WaxSThrykiYb+DnYqOtGWRNltOvas1APxBcOGz9y0FLwJGe2T7XQ2W28r2VrAln3d3j6791UucZJLMmKaA/QkC3zkeU3bZ+kpmMkmW+h+XNI7SXChOD5R9C0ETC5W7SwY8gAD8ciZ0MtoRyKdNIXkAQlFBckFRBEBw0TsSBgoIMwHM0oIDLt3fdHVqS6zNxFpnNXOSDnQNuFjeCYSucHVkm2zZEpfq5XA0R6sKB8IyY79cmPnKzGty8ogf0KzbRhSjCRJaPscHXza6gfV1pb7Qt9SHrH7h1Bll3eBuF1XZ8kkG6lId/96TGg830UnGqk4ZaP+s7QxVSzJJxQlXEEaA+EqrRlM6U6FwxSxAUA6wREes6HeoxsuNEZqMe3aJm8xVRbNHOJVHw51fdg==
Received: from leoy-yangtze.lan (211-75-219-199.hinet-ip.hinet.net. [211.75.219.199])
        by smtp.gmail.com with ESMTPSA id a19-20020a62e213000000b006e04c3b3b5esm402657pfi.163.2024.02.08.17.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 17:08:58 -0800 (PST)
Date: Fri, 9 Feb 2024 09:08:51 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Yicong Yang <yangyicong@huawei.com>, will@kernel.org,
	john.g.garry@oracle.com, james.clark@arm.com, mike.leach@linaro.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, jonathan.cameron@huawei.com,
	hejunhao3@huawei.com, prime.zeng@hisilicon.com,
	yangyicong@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v2] perf stat: Enable iostat mode for HiSilicon PCIe PMU
Message-ID: <20240209010851.GB297921@leoy-yangtze.lan>
References: <20240208032518.25830-1-yangyicong@huawei.com>
 <CAM9d7cga2rzcpUCa+5sZKQ3g_nC5=5XhSdkX1bRCQQUJca8uSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cga2rzcpUCa+5sZKQ3g_nC5=5XhSdkX1bRCQQUJca8uSw@mail.gmail.com>

On Thu, Feb 08, 2024 at 03:58:11PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Feb 7, 2024 at 7:29???PM Yicong Yang <yangyicong@huawei.com> wrote:
> >
> > From: Yicong Yang <yangyicong@hisilicon.com>
> >
> > Some HiSilicon platforms provide PCIe PMU devices for monitoring the
> > throughput and latency of PCIe traffic. With the support of PCIe PMU
> > we can enable the perf iostat mode.
> 
> Hmm.. so it only works for HiSilicon.  What if users run it on a different
> platform?  I think ARM should care about this.

I will give a review for this patch.

Thanks,
Leo
