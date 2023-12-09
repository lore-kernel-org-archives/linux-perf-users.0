Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niSttaUe"
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4AF10F1
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Dec 2023 22:17:33 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b45ab9e084so100920439f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Dec 2023 22:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702102653; x=1702707453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8morqy+oi5xTO4rvPEOCUiaHl77jTCM6O5fLdzv0Xk=;
        b=niSttaUe/OgdndU4gtWFh4rz901eWG8HrhIV1E01wWOYJ3rfpmpxD9frV5qdsN7MK6
         7cJzp1fF9hL6RTg67tSGzEvSmlhBZbVIkyyKOPE59uSMvr7PIpfk1NZvqPDxBQhfLAfQ
         48KPrNZevLUmdjzno4nRqs1H1bSNGay3JCG+dcKG86ZaMH/pX9gm87X4SI3R1nrPdzQ8
         fdpKG4BZldLjzI7HnmJSWXuZs5PVfbbj3aWe9XeEFXAoolWwzRdnqruVY1UxvYXy3ZhA
         Gz92VRWjuW0V1a9LbINjfARRCTo6AryrcXF7zLCcEWVFL0Q/2NxS3pWM/SR4TS8kCWfA
         nD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702102653; x=1702707453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8morqy+oi5xTO4rvPEOCUiaHl77jTCM6O5fLdzv0Xk=;
        b=mttbwKSIbfnWoEwhkXAjR4CW5sB1wUAnxx3Al2cxzXr2svND93ADCS6AUeyKB7t5ji
         ttMuqloLfQJH05lUW5MPSaKSQIIO6ipjM1yxYS1heMjzo/tkXfPP67cV4K0p4MxAJiHJ
         haV0BSyPF+K3Xyomdh2YS9SWrsVcqGgIAO6EKy0LeNI5pr5ilFgGSPrIqlQhwk/mb64y
         V4eAtxMyy2vxM14Ty53g+QXaF7EAjIf5Hla7SEGqyEN9vUNu9uAVc0zAuZcKx/S8o97Q
         stiGqYUoNpM26ZK9b7rPP1SU5+ZVNfk2J/pZzPLzQhkGKbs1ypEheim1r4F7xkFec1Ln
         ApNQ==
X-Gm-Message-State: AOJu0YzNEK5ZWuqot77O4QUsDb3c1H37YA+N8RwUrklxYmFizhYVzYv2
	4IQiXtNi9T+o4CDG5lsRd8qqFg==
X-Google-Smtp-Source: AGHT+IE+UBNr8HK1+udhvTGk4IOL5QEH22TaHi9x7KhWqht8lnlPI8fgDVxefasgjkDUjaMf5tpWVg==
X-Received: by 2002:a6b:4910:0:b0:7b6:eb7c:7078 with SMTP id u16-20020a6b4910000000b007b6eb7c7078mr1649448iob.0.1702102653115;
        Fri, 08 Dec 2023 22:17:33 -0800 (PST)
Received: from leoy-yangtze.lan ([94.177.131.71])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b001d1d27259cesm2690509plg.180.2023.12.08.22.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:17:32 -0800 (PST)
Date: Sat, 9 Dec 2023 14:17:23 +0800
From: Leo Yan <leo.yan@linaro.org>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
	adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
	james.clark@arm.com, mike.leach@linaro.org,
	yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com, ravi.bangoria@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 4/5] perf mem: Clean up perf_mem_event__supported()
Message-ID: <20231209061723.GC2116834@leoy-yangtze.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207192338.400336-5-kan.liang@linux.intel.com>

On Thu, Dec 07, 2023 at 11:23:37AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> For some ARCHs, e.g., ARM and AMD, to get the availability of the
> mem-events, perf checks the existence of a specific PMU. For the other
> ARCHs, e.g., Intel and Power, perf has to check the existence of some
> specific events.
> 
> The current perf only iterates the mem-events-supported PMUs. It's not
> required to check the existence of a specific PMU anymore.

With this change, both Arm and AMD archs have no chance to detect if the
hardware (or the device driver) is supported and the tool will always
take the memory events are exited on the system, right?

Thanks,
Leo
