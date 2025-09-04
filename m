Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94E2BDC05;
	Thu,  4 Sep 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972314; cv=none; b=ShaZ2eEga7JlENKt2bC4SIciOGaVoMnEAMlde5waH+/gijrX1yOoA/kffBwieQzEH6pSrOuJK4oG5DlQVwoFojMAuPDvO5K2p051Xb1J+cgeJnmv/wnmzDC/GkC1OWul14VVm7XurSew9R+7C2kmeqPuz5pBkQA9oTuC28dHcX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972314; c=relaxed/simple;
	bh=rE0KWJrKeJt22T4AYZywb92G0O/oP+xSleFmSknemCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEyTAJRC/ba7wzwOC2DzQB0mx9Cw7WvwL4TtP9fZNUGrToPpJ7/wGwfeEMhvJgHgEY4pgxuhso/mLtee6omesa8PEagNYDurnIFW1eUnPcMnoIQXxpE758+xCn5UzjOcwVOGr+B6uhRYdQ0vwktQ8hja/hfkuurzPFVqJayyy+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCfOKTW5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCfOKTW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3835BC4CEF0;
	Thu,  4 Sep 2025 07:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972314;
	bh=rE0KWJrKeJt22T4AYZywb92G0O/oP+xSleFmSknemCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCfOKTW5QmsGiI7lfLidL4A7U/TqtlUK8B/Z+xXpeK+xOv/o1wrjKImlBIm7qoqyp
	 vWrVbcvDgLaQtrmSWW9QnceFY+vaWOifv+eJybBINP9rST+hO74eb4Hh1G6Wt2hT2x
	 oYH7Xt4OZmWo0rLzgu7qils5+FxRsbp4e+uUQ+8jKyYxWZeWCUnNCkDNyYWUdjqt7g
	 bJ8p8EcEjqpIpV+HifHSHDE67CtJhrDcNFsZZRE5m7jVHfjhWAlsDpevdqJdKUJbMq
	 3I219i+m22wZU7OsFAA2EZ6VaPOVZSpZ+B3A1yVRyCh2uk7Et7rKEY6W+5qJAvvCe4
	 y76jW/0hht3XQ==
Date: Thu, 4 Sep 2025 10:51:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
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
Message-ID: <aLlFDQkWBF0N7xmk@kernel.org>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-4-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904002126.1514566-4-wangjinchao600@gmail.com>

On Thu, Sep 04, 2025 at 08:21:00AM +0800, Jinchao Wang wrote:
> Provide the /proc/kstackwatch file to read or update the KSW configuration.
> Writing a valid config string starts watching; empty input stops watching.
> Invalid input stops watching and reports an error.
> 
> Allocate a ksw_config struct on module init and free it on exit.
> Manage watching state with ksw_start_watching() and ksw_stop_watching().
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  mm/kstackwatch/kernel.c | 140 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
> 
> diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
> index 4a6dc49449fe..95ade95abde1 100644
> --- a/mm/kstackwatch/kernel.c
> +++ b/mm/kstackwatch/kernel.c
> @@ -1,7 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/kstrtox.h>
>  #include <linux/module.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
>  #include <linux/string.h>
> +#include <linux/uaccess.h>
>  
>  #include "kstackwatch.h"
>  
> @@ -9,6 +12,29 @@ MODULE_AUTHOR("Jinchao Wang");
>  MODULE_DESCRIPTION("Kernel Stack Watch");
>  MODULE_LICENSE("GPL");
>  
> +struct ksw_config *ksw_config;

Does a global ksw_config imply that this is a singleton?
What happens when there are several "echo .. > /proc/kstackwatch"?
And even more interesting what happens if they are parallel?

> +bool watching_active;
> +
> +bool panic_on_catch;
> +module_param(panic_on_catch, bool, 0644);
> +MODULE_PARM_DESC(panic_on_catch,
> +		 "Trigger a kernel panic immediately on corruption catch");
> +
> +static int ksw_start_watching(void)
> +{
> +	watching_active = true;
> +
> +	pr_info("KSW: start watching %s\n", ksw_config->config_str);
> +	return 0;
> +}
> +
> +static void ksw_stop_watching(void)
> +{
> +	watching_active = false;
> +
> +	pr_info("KSW: stop watching %s\n", ksw_config->config_str);

This module is overly verbose. Do you really need all the printks?

> +}

...

>  static int __init kstackwatch_init(void)
>  {
> +	ksw_config = kmalloc(sizeof(*ksw_config), GFP_KERNEL);
> +	if (!ksw_config)
> +		return -ENOMEM;
> +
> +	/* Create proc interface */
> +	if (!proc_create("kstackwatch", 0644, NULL, &kstackwatch_proc_ops)) {

ksw_config must be freed here

> +		pr_err("KSW: create proc kstackwatch fail");
> +		return -ENOMEM;
> +	}
> +
>  	pr_info("KSW: module loaded\n");
>  	pr_info("KSW: usage:\n");
>  	pr_info("KSW: echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
> @@ -85,6 +217,14 @@ static int __init kstackwatch_init(void)
>  
>  static void __exit kstackwatch_exit(void)
>  {
> +	/* Cleanup active watching */
> +	if (watching_active)
> +		ksw_stop_watching();
> +
> +	/* Remove proc interface */
> +	remove_proc_entry("kstackwatch", NULL);
> +	kfree(ksw_config);
> +
>  	pr_info("KSW: Module unloaded\n");
>  }
>  
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
