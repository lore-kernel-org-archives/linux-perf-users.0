Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D24258A;
	Mon,  8 Sep 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311396; cv=none; b=Wfk4ILweZ92ZZqmQL4yHO21gHIHubQ64DKAr2SVG2gGB/Y8dOjm5zcvXRvXxgeYxD9jcx3sqouBYSHnqyLGG8QnVXHwmKKsNKDkP87AosGPOGQobuok2kUYzooE9y1krU7Adb1/f+yEEYCPnV8IQltimjmDCGl0BDB0RGRDqfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311396; c=relaxed/simple;
	bh=PV29dD6DVuP426ep3uaLTMwwjY+0ljmyrjL4Mo1Uw28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQGBKaCuIrGnXcdf563cGIWf0LLHr/jn8tXDy/m3vXyjUB9Q8QV0Skf0UUNjDEj+b2LstE/inoinUJLAXDD0luQGWCSSqCvuJ4Zin6fXvlbTp8zHS1KxgbmCuork8c4aP/WqNhGnjzP3AkYZug60v9Po+2uTD/94217rTdpzeMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaEsJ8Ee; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaEsJ8Ee"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b523af71683so106687a12.3;
        Sun, 07 Sep 2025 23:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757311394; x=1757916194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZNWdSFuO4znuntXPxqyseJzzxpqp1vGgxisD3Po8ZRc=;
        b=DaEsJ8EeJO47VpixqjoWV8iYuWmqakBj2NkEI0GB1guQmlokwiqsF0Gq5HnHa2bdOQ
         6ty2gcur47eGGFkLvdPQev91ViUoIB19GtS8bz1qZ/rxIlvHFAj7Y6Qiyv2XFh+YhFOj
         6zDk/3Uu3DEQHvNbC1C5fTU23NMTwSsqBMncvIugNZ76XBVXERv+h+1k1rPKHAFyZWmn
         zxa5AUD32XnQ/y2IGdxy64r1v59AMl1XNUET1Lw7MjOg/sVY0URwNCCxdLWI8zDvkKWp
         QTd/2f/HDBrd2S8mN9y+VGWlWcp1bqIAFo6bp/JQc8CUJqSR9rLmXHCYozAkldKNmfo9
         cUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757311394; x=1757916194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNWdSFuO4znuntXPxqyseJzzxpqp1vGgxisD3Po8ZRc=;
        b=dhwuM99yyLcvtccL2G3NPZ0DLjMPFXb+APgKeJ6rTZDG7A3cmZVvKHcaOr6R9XeN1q
         0zNN/sVCs1dJx4hL/M9hSpMtGq+K0IAjWA8qjTQhJpdZsvL7fn7KT7uMxmArD1ObvHT9
         0MTTKscJJjV9RGY6G0lw3Pm86SckaS2wmV8vMOefck8n1Ueg/yxgqSE+z+LfHU6Cx/VM
         Jet16wfNIl0h5FUM5STh0g7Hq8zin8fxB3cYaymMR4xOdxvtrCTV6K6VHTE+rJzOs6uT
         tC+a18i2al0q2cqUUWLjB66tI437/N1cdVkzy665+5DoxgoubwoW74dw5RjKV3cVH3NV
         yw4g==
X-Forwarded-Encrypted: i=1; AJvYcCU/97b06eo598SEJJIQisg/aGTw+0i/PH9RC5WwMnh6FIYFaoJgAZ+1+ekBuwrVwcCKrLenogGjNCcswVkSxtoCxQ==@vger.kernel.org, AJvYcCVhJ3RLUZddcb5LeDJsaS8SWemsOE3mnPrdO0vBJCgqnrf8xjA4IAaXjZBH/jLl3v3vz/aY/wVphSSRjhnIvo+kvdQI@vger.kernel.org, AJvYcCWdFWGxd/II7EQOcfMU0Gi4A0Xe54Q/yXD/1SbBNd8aKagM3lwiMJxuttTJ7hVcvaeDZxajpbk9oJeZapM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysHfSt3KFg/xwzzHAvKakNgF3rEbFnnpANphjBDZOH1vSHFw18
	fjt+nu8BqQMKEf9TKdIsgUl0dgtFjULPSx8HNy/AvcFbmH2QlWdvIti8
X-Gm-Gg: ASbGncuPpBX/Mz4tA3f5MuXFZ0XQDFRWYXMNibCtYAMAZrhAZ4S9wuccboq6smUW8Tm
	1k16dL9rBftT7OtyrowTewQH0qL/VDi1VxFbZboQ+PpVg5uwW8mWognFRrzWoYUGZYp1sZsBsbQ
	FJEqCxpBP6DcUt2kecD6iEz97MpX6gRi0W9aRjmUg1kzCVWn6EHt+TVpry/FQg72Tgvs6DWiy+/
	KT1VKkRyJ92vOHOsp1QV3QZDbJJHlp+skmSJeX5dvpzjYdcdo0dqlK5iIXynzyf/Q2XclXjr9SV
	ArKN9XfUNbej9bGpWtmct1GJJSiWVPPjE4e+OXj2t8bThQ5cpp6xcTtqFPK3B+qysuE1gz5JvLR
	as1HAlWYbCz+NAoYWlxKgFNE+aMwLHeelp32tdA==
X-Google-Smtp-Source: AGHT+IGaMF5Ba8B6t4H2vzMTPALt55ZTJj/NUECpMhpJBlfxz2OnagbMjg7YIyiTxu2dTK5kF1UxJg==
X-Received: by 2002:a17:902:e541:b0:24c:9c29:c9d1 with SMTP id d9443c01a7336-2517493a09dmr107170825ad.59.1757311393773;
        Sun, 07 Sep 2025 23:03:13 -0700 (PDT)
Received: from localhost ([103.121.208.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b11833ac7sm166868285ad.55.2025.09.07.23.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:03:13 -0700 (PDT)
Date: Mon, 8 Sep 2025 14:03:11 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/18] mm/ksw: add /proc/kstackwatch interface
Message-ID: <aL5xnxEO0NP5VlpL@mdev>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-4-wangjinchao600@gmail.com>
 <aLlFDQkWBF0N7xmk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLlFDQkWBF0N7xmk@kernel.org>

On Thu, Sep 04, 2025 at 10:51:41AM +0300, Mike Rapoport wrote:
> On Thu, Sep 04, 2025 at 08:21:00AM +0800, Jinchao Wang wrote:
> > Provide the /proc/kstackwatch file to read or update the KSW configuration.
> > Writing a valid config string starts watching; empty input stops watching.
> > Invalid input stops watching and reports an error.
> > 
> > Allocate a ksw_config struct on module init and free it on exit.
> > Manage watching state with ksw_start_watching() and ksw_stop_watching().
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  mm/kstackwatch/kernel.c | 140 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 140 insertions(+)
> > 
> > diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
> > index 4a6dc49449fe..95ade95abde1 100644
> > --- a/mm/kstackwatch/kernel.c
> > +++ b/mm/kstackwatch/kernel.c
> > @@ -1,7 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/kstrtox.h>
> >  #include <linux/module.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/string.h>
> > +#include <linux/uaccess.h>
> >  
> >  #include "kstackwatch.h"
> >  
> > @@ -9,6 +12,29 @@ MODULE_AUTHOR("Jinchao Wang");
> >  MODULE_DESCRIPTION("Kernel Stack Watch");
> >  MODULE_LICENSE("GPL");
> >  
> > +struct ksw_config *ksw_config;
> 
> Does a global ksw_config imply that this is a singleton?
Yes, it is.
> What happens when there are several "echo .. > /proc/kstackwatch"?
> And even more interesting what happens if they are parallel?
I did not consider this deeply enough.
I will address it properly in the next series.
Thank you for pointing it out.
> 
> > +bool watching_active;
> > +
> > +bool panic_on_catch;
> > +module_param(panic_on_catch, bool, 0644);
> > +MODULE_PARM_DESC(panic_on_catch,
> > +		 "Trigger a kernel panic immediately on corruption catch");
> > +
> > +static int ksw_start_watching(void)
> > +{
> > +	watching_active = true;
> > +
> > +	pr_info("KSW: start watching %s\n", ksw_config->config_str);
> > +	return 0;
> > +}
> > +
> > +static void ksw_stop_watching(void)
> > +{
> > +	watching_active = false;
> > +
> > +	pr_info("KSW: stop watching %s\n", ksw_config->config_str);
> 
> This module is overly verbose. Do you really need all the printks?
You’re right — many of these printks are for early debugging and not
needed for production. I will remove or downgrade them to pr_debug() in
the next version.

For critical paths, I’ll ensure only actionable or WARN-level messages
remain.

Appreciate the push for cleaner logging.
> 
> > +}
> 
> ...
> 
> >  static int __init kstackwatch_init(void)
> >  {
> > +	ksw_config = kmalloc(sizeof(*ksw_config), GFP_KERNEL);
> > +	if (!ksw_config)
> > +		return -ENOMEM;
> > +
> > +	/* Create proc interface */
> > +	if (!proc_create("kstackwatch", 0644, NULL, &kstackwatch_proc_ops)) {
> 
> ksw_config must be freed here
> 
> > +		pr_err("KSW: create proc kstackwatch fail");
> > +		return -ENOMEM;
> > +	}
> > +
> >  	pr_info("KSW: module loaded\n");
> >  	pr_info("KSW: usage:\n");
> >  	pr_info("KSW: echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
> > @@ -85,6 +217,14 @@ static int __init kstackwatch_init(void)
> >  
> >  static void __exit kstackwatch_exit(void)
> >  {
> > +	/* Cleanup active watching */
> > +	if (watching_active)
> > +		ksw_stop_watching();
> > +
> > +	/* Remove proc interface */
> > +	remove_proc_entry("kstackwatch", NULL);
> > +	kfree(ksw_config);
> > +
> >  	pr_info("KSW: Module unloaded\n");
> >  }
> >  
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Sincerely yours,
> Mike.
