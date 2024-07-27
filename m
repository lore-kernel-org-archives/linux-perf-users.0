Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18671B80F
	for <linux-perf-users@vger.kernel.org>; Sat, 27 Jul 2024 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722039612; cv=none; b=FS3LXlFdymq5kaQvpRmHF0ysPyHveAsjZP+7W9TZUVddUdbzu6hiaUEyhiy6EMIzbFkfdXFJnI4mPGVwobXW8PyS+7cTMC8QBb6frAuXIuDoW0Do5h2ENi1GZPkjbmSw+f+H8yxofv5JkvhQ6rsVglFt4v/HzPNaBK8hMW2OiMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722039612; c=relaxed/simple;
	bh=sa4yBAECHwgGpwCr3wgMHNdN70kBYtuWIejvmuuAW/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWpNQa4TZ04wcvQhWTOX2R3fhdwj88Nc/fTfev5HsRSEoyIKUMs/REjegRoWNY+uqpg2at7HGT3AfW3osM4+iXehIf10KoLhpeLokFJROPOgMDVY99dR9OhXEWk/DKx2dP1bp3GvhzIauU6eQUmvtVDmX28OaFrPby8mDQUBAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bLDAZ4nr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bLDAZ4nr"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd69e44596so8564645ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 17:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722039609; x=1722644409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7cfRKhELYrR6N+WAn/cHOmvMOMbYiblLooGHuWfHl78=;
        b=bLDAZ4nri0XfQbrLvNYry7GrA/TM530BpuDU3HSFIyhqcXznGL5GU5pbVV4EiL3lKg
         dwcXubcfwFycgZhS/khPlDvW8I4zHn4mlLcMcjoSKHDE9mqCZzs+rVIAe0YZDnjsb3ud
         HL7LRPL+IoQRSzhtDWaFVvL7I5Am5nF88icm3f2Nt+GazDRfVIvZQ7bCnsusrQlTCYeb
         71UH0SqWVlJU919s2/5ViPC1Gd2zNz0Z6pRb1Rgfk47glAnjzMFG1LvJeK+xipMDV0/q
         SafA8lH3mYYAo0wUcmCfcU2RX/7KwyW3c85Mb8uuun1eV6jfeYoYi96jzSoIbpxcWSoZ
         gkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722039609; x=1722644409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cfRKhELYrR6N+WAn/cHOmvMOMbYiblLooGHuWfHl78=;
        b=E992h7XdgQJ90p2dJT2kXpOFCHcDhru5o4EwQwrjtZWK3ltg57BV4WkexlGprwhRsO
         TlgAg8NIn+PaaqKfsDgD0Bz3cKpV6tnvbt4Zl0PlfHvPyYYI8+ir0qWMlSE8uElVMoJp
         3/k5cQwA/Zwr6dOJq8Y4aU47qtp4c/YP1cFeqt0e0lh6INx1y1m9eb8BsJyZIDNQTa1b
         SCtFoMy0midE/KbdUxZggD846+lsH1gUmttMoVDtjrZWC2qDShP4aWHkJK0mmyus8A5u
         SgE5FdeC3XbzIvisMCeZeFwfbYBCrb4TdALeDm6WmWI2cYMIfGOiAeYfHmeaOtEwjAFU
         WPfg==
X-Gm-Message-State: AOJu0YzLURnq9jDCDxw1qWf7kMAt9GPnTheXiChez7L+oSUcbL41pDOO
	i1yI24oa9XukOIFmd0vUORwF28PMTI5GmV6bFoClE8pEd9z8YxUPRP1iKmi+I8k=
X-Google-Smtp-Source: AGHT+IEXHbNb4J1eG46T35F231HTl1OqJcIeNnTUKLh9oVLH74eULbpUN221fMmbx7avKG2UWl0Q2g==
X-Received: by 2002:a17:903:234d:b0:1fc:4aa0:fad2 with SMTP id d9443c01a7336-1ff04a23881mr17462085ad.6.1722039608934;
        Fri, 26 Jul 2024 17:20:08 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c88a39sm38839015ad.28.2024.07.26.17.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 17:20:08 -0700 (PDT)
Date: Fri, 26 Jul 2024 17:20:06 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
Message-ID: <ZqQ9NnEF8oDGhatU@ghost>
References: <20240724-perf_set_event_limit-v1-0-b8a642a7cb54@rivosinc.com>
 <20240724-perf_set_event_limit-v1-1-b8a642a7cb54@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724-perf_set_event_limit-v1-1-b8a642a7cb54@rivosinc.com>

On Wed, Jul 24, 2024 at 03:43:25PM -0700, Charlie Jenkins wrote:
> PERF_EVENT_IOC_REFRESH immediately enables after incrementing
> event_limit.  Provide a new ioctl flag that allows programs to increment
> event_limit without enabling the event. A usecase for this is to set an
> event_limit in combination with enable_on_exec.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  include/linux/perf_event.h            |  4 ++--
>  include/uapi/linux/perf_event.h       |  1 +
>  kernel/events/core.c                  | 17 +++++++++++------
>  tools/include/uapi/linux/perf_event.h |  1 +
>  4 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index a5304ae8c654..40025a5eb98a 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1103,7 +1103,7 @@ extern int perf_event_task_enable(void);
>  
>  extern void perf_pmu_resched(struct pmu *pmu);
>  
> -extern int perf_event_refresh(struct perf_event *event, int refresh);
> +extern int perf_event_refresh(struct perf_event *event, int refresh, bool enable);
>  extern void perf_event_update_userpage(struct perf_event *event);
>  extern int perf_event_release_kernel(struct perf_event *event);
>  extern struct perf_event *
> @@ -1770,7 +1770,7 @@ static inline int perf_event_read_local(struct perf_event *event, u64 *value,
>  static inline void perf_event_print_debug(void)				{ }
>  static inline int perf_event_task_disable(void)				{ return -EINVAL; }
>  static inline int perf_event_task_enable(void)				{ return -EINVAL; }
> -static inline int perf_event_refresh(struct perf_event *event, int refresh)
> +static inline int perf_event_refresh(struct perf_event *event, int refresh, bool enable)
>  {
>  	return -EINVAL;
>  }
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 3a64499b0f5d..992f51effb27 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -560,6 +560,7 @@ struct perf_event_query_bpf {
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
>  #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
>  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
> +#define PERF_EVENT_IOC_INC_EVENT_LIMIT		_IO ('$', 12)
>  
>  enum perf_event_ioc_flags {
>  	PERF_IOC_FLAG_GROUP		= 1U << 0,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8f908f077935..b9d009733ace 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3142,7 +3142,7 @@ void perf_event_addr_filters_sync(struct perf_event *event)
>  }
>  EXPORT_SYMBOL_GPL(perf_event_addr_filters_sync);
>  
> -static int _perf_event_refresh(struct perf_event *event, int refresh)
> +static int _perf_event_refresh(struct perf_event *event, int refresh, bool enable)
>  {
>  	/*
>  	 * not supported on inherited events
> @@ -3151,7 +3151,8 @@ static int _perf_event_refresh(struct perf_event *event, int refresh)
>  		return -EINVAL;
>  
>  	atomic_add(refresh, &event->event_limit);
> -	_perf_event_enable(event);
> +	if (enable)
> +		_perf_event_enable(event);
>  
>  	return 0;
>  }
> @@ -3159,13 +3160,13 @@ static int _perf_event_refresh(struct perf_event *event, int refresh)
>  /*
>   * See perf_event_disable()
>   */
> -int perf_event_refresh(struct perf_event *event, int refresh)
> +int perf_event_refresh(struct perf_event *event, int refresh, bool enable)
>  {
>  	struct perf_event_context *ctx;
>  	int ret;
>  
>  	ctx = perf_event_ctx_lock(event);
> -	ret = _perf_event_refresh(event, refresh);
> +	ret = _perf_event_refresh(event, refresh, enable);
>  	perf_event_ctx_unlock(event, ctx);
>  
>  	return ret;
> @@ -5920,7 +5921,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
>  		break;
>  
>  	case PERF_EVENT_IOC_REFRESH:
> -		return _perf_event_refresh(event, arg);
> +		return _perf_event_refresh(event, arg, true);
>  
>  	case PERF_EVENT_IOC_PERIOD:
>  	{
> @@ -6006,6 +6007,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
>  
>  		return perf_event_modify_attr(event,  &new_attr);
>  	}
> +
> +	case PERF_EVENT_IOC_INC_EVENT_LIMIT:
> +		return _perf_event_refresh(event, arg, false);
> +
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -6721,7 +6726,7 @@ void perf_event_wakeup(struct perf_event *event)
>  	ring_buffer_wakeup(event);
>  
>  	if (event->pending_kill) {
> -		kill_fasync(perf_event_fasync(event), SIGIO, event->pending_kill);
> +		kill_fasync(perf_event_fasync(event), SIGTRAP, event->pending_kill);

This was a debug change that wasn't supposed to make it into this patch.
In the next version I will remove this.

- Charlie

>  		event->pending_kill = 0;
>  	}
>  }
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 3a64499b0f5d..992f51effb27 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -560,6 +560,7 @@ struct perf_event_query_bpf {
>  #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
>  #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
>  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
> +#define PERF_EVENT_IOC_INC_EVENT_LIMIT		_IO ('$', 12)
>  
>  enum perf_event_ioc_flags {
>  	PERF_IOC_FLAG_GROUP		= 1U << 0,
> 
> -- 
> 2.44.0
> 
