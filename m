Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB515624D
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766011; cv=none; b=rESJohmLW0SgAF+86V2QmEDJVGOFoVWF55ODwQKHfTb6YqkNjw3z6uxzordm3OHlJzAjYqfJ8w0Q7UekV+zCGzL01Z2JLybRgCiJ0NTTK2990QMPOh0qzoEVQWSyTmjgubqfXOEu8BSHz7q+50MhitkqAa1vRWPIzpTLNDpxtzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766011; c=relaxed/simple;
	bh=VUaEopFT8QpBRBeRXFpCrrY3LYAx7YydiEUYySF2rP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGe2FTD026iRZRMIg50eObEkLUrMNxMhMVPRO6clzsbxT9w4FtkoXC0GZjqr38wiOuEQY5RywW6QjefYAh4pHBbXFExEBanBuGSnukRvi6u4NkJcddGlqVUMVn6rneE1z3mTpFD91bonbeauX2PKzwD//TEpiOVE5JX+CvaT4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNhRhLbl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNhRhLbl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27c369f898fso5489745ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 19:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758766009; x=1759370809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDDNQxOCofAWfoIkXGgKX3OgUnzUt3+cN5qe0WBH0Fk=;
        b=LNhRhLbloMI2cn+inv/yExr/cRovpGPm4+svrmh6pemCipiiTdza6OcPbhjz+wSIj5
         XD9sTST8Ny1FnPEdL+4JR4lXDV5A36e5LgOHCyIJqQSM+vM989bjOS+a2UvEZnlTc19F
         dXR9RAyrYsGYw33RNUJlbh1lNuexFlk11CzjL1LMEqYx3/APh3cbinJUEH1P89SrTkl5
         UbpBCa7SLHb/CaL7aVQXDi12DP5mar0vLqBF8AeJqFbM2HZO12ZfYtkDU5ARA0yTYyzl
         lYviQBxLu1E6gA32VSQFS1bAjPydax1HKY5J+NS9/vkIML6xfEe/NVwDQFqiXvrkdnPq
         9P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758766009; x=1759370809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDDNQxOCofAWfoIkXGgKX3OgUnzUt3+cN5qe0WBH0Fk=;
        b=p+35WcWfIjQtVnOHatXr9sO04/WbBsMTMuh40QDKlYnbv3uHJxoDqpMbQ04TIOfkAi
         CtwZieaoHqcmNCG4q2mk124YJOBRdtqSBwWPxnM4U37FFRyR8bostf42yfqrYhF1M11p
         B/cMdfQ1WkRA2DeOjwNohklus+HQA2MbrVncqmSeZ6mdVDacwASNLgC0DeEF23iiSXaW
         NUIqmPVMvRoqJzf8jAXa3D95nmo3XNEtmIY34yO+dSjwJZkk8pagGsnot4yuYD7uhEPm
         Pot1UCeXCqrdRSO5VtZVjnQ+Bai4+KpwElqdqDRHlS+jJvTIJnaVZLhzjsZGFfxMA9x6
         M3fw==
X-Forwarded-Encrypted: i=1; AJvYcCULbQofxqmfwfUbQNwFPksP8NrdPhGbap70ygheJKFkAHd9WbkJRnCa1sT1RXncczdgOgaFhnz8KN+3HayLiD0k@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4VN3bjag37apiYQHN1nSQRmFSgjWd+3NHMeNuqEzZor/tX3yR
	gG31tIPDLKtD55+zb6l0SF8DPVumngdybw7h9xskxUkQQFmXXc12Zx8N
X-Gm-Gg: ASbGnctNx8TRrKIAprj9hG4THEUQ6eyB4UodtfqiCFoSmzfO6u+7FIC3iFQrQXYHdt0
	RMvhIQxf2MKGGTCHks/hZiExgrSiiw2JyB6mwpXnHEtktVQxyppsEwAUy851QHfBqPBoWbBPc94
	CmBerxVlLuIXt9a0GBzQt1Ik/w8A9R1JLGw+1u1qrKPg13lUVVEAmcCC7KBnMQ+Q+MHBrD4Ue69
	ubkdu7IgHxEQuabHVbrSzmCubSkMunID+Mk/oUjYWVazM7vz8AucpnhEXCxy+ZvUyoLojAvB6mp
	hlVJQ7A9WFh8GN0WbxiG+eJmLuX1oOsJLSQXzh2yoFs67x05gM5G3Tp9z3CvdQ2Dg04Uy7ce4J9
	D3KqykvPXVFr5vU9P13GmsHg=
X-Google-Smtp-Source: AGHT+IGmMrm8xksFP6ju22OaumMbD6YwInELL6WKXRm9IlZDS3eIrrfgfG3Q7BtCL53wgsMXve+VwA==
X-Received: by 2002:a17:902:f54c:b0:271:479d:3de3 with SMTP id d9443c01a7336-27ed49c7763mr18733235ad.12.1758766009065;
        Wed, 24 Sep 2025 19:06:49 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf181sm6940845ad.28.2025.09.24.19.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:06:48 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:06:44 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
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
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/23] mm/ksw: add test module
Message-ID: <aNSjtMdxZXdhgPRA@mdev>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
 <20250924115931.197077-1-wangjinchao600@gmail.com>
 <20250924115931.197077-2-wangjinchao600@gmail.com>
 <CANpmjNNnVx3=dQsoHL+T-95Z_iprCd3FXeYpnHdmi4d06X-x_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNnVx3=dQsoHL+T-95Z_iprCd3FXeYpnHdmi4d06X-x_g@mail.gmail.com>

On Wed, Sep 24, 2025 at 10:44:50PM +0200, Marco Elver wrote:
> On Wed, 24 Sept 2025 at 14:00, Jinchao Wang <wangjinchao600@gmail.com> wrote:
> >
> > Introduce a separate test module to validate functionality in controlled
> > scenarios.
> >
> > The module provides a proc interface (/proc/kstackwatch_test) that allows
> > triggering specific test cases via simple commands:
> >
> >   echo test0 > /proc/kstackwatch_test
> 
> This should not be in /proc/ - if anything, it should go into debugfs.
Thanks, will fix in next version.
> 
> > Test module is built with optimizations disabled to ensure predictable
> > behavior.
> >
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  mm/Kconfig.debug        |  10 ++++
> >  mm/kstackwatch/Makefile |   6 ++
> >  mm/kstackwatch/test.c   | 122 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 138 insertions(+)
> >  create mode 100644 mm/kstackwatch/test.c
> >
> > diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> > index 89be351c0be5..291dd8a78b98 100644
> > --- a/mm/Kconfig.debug
> > +++ b/mm/Kconfig.debug
> > @@ -317,3 +317,13 @@ config KSTACK_WATCH
> >           A lightweight real-time debugging tool to detect stack corrupting.
> >
> >           If unsure, say N.
> > +
> > +config KSTACK_WATCH_TEST
> > +       tristate "KStackWatch Test Module"
> > +       depends on KSTACK_WATCH
> > +       help
> > +         This module provides controlled stack corruption scenarios to verify
> > +         the functionality of KStackWatch. It is useful for development and
> > +         validation of KStackWatch mechanism.
> > +
> > +         If unsure, say N.
> > diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
> > index 84a46cb9a766..d007b8dcd1c6 100644
> > --- a/mm/kstackwatch/Makefile
> > +++ b/mm/kstackwatch/Makefile
> > @@ -1,2 +1,8 @@
> >  obj-$(CONFIG_KSTACK_WATCH)     += kstackwatch.o
> >  kstackwatch-y := kernel.o stack.o watch.o
> > +
> > +obj-$(CONFIG_KSTACK_WATCH_TEST)        += kstackwatch_test.o
> > +kstackwatch_test-y := test.o
> > +CFLAGS_test.o := -fno-inline \
> > +               -fno-optimize-sibling-calls \
> > +               -fno-pic -fno-pie -O0 -Og
> > diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
> > new file mode 100644
> > index 000000000000..1ed98931cc51
> > --- /dev/null
> > +++ b/mm/kstackwatch/test.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/delay.h>
> > +#include <linux/kthread.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/prandom.h>
> > +#include <linux/printk.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/random.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/string.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include "kstackwatch.h"
> > +
> > +static struct proc_dir_entry *test_proc;
> > +
> > +#define BUFFER_SIZE 16
> > +#define MAX_DEPTH 6
> > +
> > +struct work_node {
> > +       ulong *ptr;
> > +       struct completion done;
> > +       struct list_head list;
> > +};
> > +
> > +static DECLARE_COMPLETION(work_res);
> > +static DEFINE_MUTEX(work_mutex);
> > +static LIST_HEAD(work_list);
> > +
> > +static void test_watch_fire(void)
> > +{
> > +       u64 buffer[BUFFER_SIZE] = { 0 };
> > +
> > +       pr_info("entry of %s\n", __func__);
> > +       ksw_watch_show();
> > +       ksw_watch_fire();
> > +       pr_info("buf[0]:%lld\n", buffer[0]);
> > +
> > +       barrier_data(buffer);
> > +       pr_info("exit of %s\n", __func__);
> > +}
> > +
> > +
> > +static ssize_t test_proc_write(struct file *file, const char __user *buffer,
> > +                              size_t count, loff_t *pos)
> > +{
> > +       char cmd[256];
> > +       int test_num;
> > +
> > +       if (count >= sizeof(cmd))
> > +               return -EINVAL;
> > +
> > +       if (copy_from_user(cmd, buffer, count))
> > +               return -EFAULT;
> > +
> > +       cmd[count] = '\0';
> > +       strim(cmd);
> > +
> > +       pr_info("received command: %s\n", cmd);
> > +
> > +       if (sscanf(cmd, "test%d", &test_num) == 1) {
> > +               switch (test_num) {
> > +               case 0:
> > +                       test_watch_fire();
> > +                       break;
> > +               default:
> > +                       pr_err("Unknown test number %d\n", test_num);
> > +                       return -EINVAL;
> > +               }
> > +       } else {
> > +               pr_err("invalid command format. Use 'testN'.\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       return count;
> > +}
> > +
> > +static ssize_t test_proc_read(struct file *file, char __user *buffer,
> > +                             size_t count, loff_t *pos)
> > +{
> > +       static const char usage[] = "KStackWatch Simplified Test Module\n"
> > +                                   "============ usage ==============\n"
> > +                                   "Usage:\n"
> > +                                   "echo test{i} > /proc/kstackwatch_test\n"
> > +                                   " test0 - test watch fire\n";
> > +
> > +       return simple_read_from_buffer(buffer, count, pos, usage,
> > +                                      strlen(usage));
> > +}
> > +
> > +static const struct proc_ops test_proc_ops = {
> > +       .proc_read = test_proc_read,
> > +       .proc_write = test_proc_write,
> > +};
> > +
> > +static int __init kstackwatch_test_init(void)
> > +{
> > +       test_proc = proc_create("kstackwatch_test", 0600, NULL, &test_proc_ops);
> > +       if (!test_proc) {
> > +               pr_err("Failed to create proc entry\n");
> > +               return -ENOMEM;
> > +       }
> > +       pr_info("module loaded\n");
> > +       return 0;
> > +}
> > +
> > +static void __exit kstackwatch_test_exit(void)
> > +{
> > +       if (test_proc)
> > +               remove_proc_entry("kstackwatch_test", NULL);
> > +       pr_info("module unloaded\n");
> > +}
> > +
> > +module_init(kstackwatch_test_init);
> > +module_exit(kstackwatch_test_exit);
> > +
> > +MODULE_AUTHOR("Jinchao Wang");
> > +MODULE_DESCRIPTION("Simple KStackWatch Test Module");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.43.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250924115931.197077-2-wangjinchao600%40gmail.com.

-- 
Jinchao
