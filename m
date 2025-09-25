Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F572E0921
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766052; cv=none; b=PoYPUKquYYULOiQJALEFh7WFR1a+rWHXpa41SQTV5VECEXRL5pnTknz7ffu0GJclQYFbhIcM/daYZpRZAicRTBvA3qph+4NlG7IlADLG4OMqV0a5As3cLMdxmBROXG+Klsz/j2nq/q4xQNfjBrTOpfq4Bt6rsMes6OFfFwrX0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766052; c=relaxed/simple;
	bh=COJ0vkNmeocbk8Pusq+tkqxDVCs9BpOKYM5zjdAFf64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqkY9/0onfUnw4Y8cGS7DiH+mI/fpjCkz+OMPHvZqGVkVzZk06feR+6hT+ipGPOJJTQQmekI9stM6qqcptSy04yFBK1U3/SwTGUJpDEWBIVTLEdyhDlgUpvw3SwXuDTRZNIXULRCC6Wddy5zg8LtlxBrBf4mIoW727YVzUm8JVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABYxGmlB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABYxGmlB"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso333210a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 19:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758766050; x=1759370850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3v0KAw/a5VLZK8q/426U2Svx1Ly/zqTFJD1qMEvdMs=;
        b=ABYxGmlB/DxpvZ+pISqHsz1jz0STOZR7FJR6Ttg+95ZVmHJYgW7VCwJs3OWgD6AmR9
         SZuv0iuvPO3HIDkjjVY/oxqd2+xcb5Y1EnBMwIZfiBVDiBSpclEOH3o17051pmVqHMG/
         VD/DYp2C6uXixgOOl9nBtZ9AszvFQo76Ys3duGUce1PsY6xGEImC2ZKPvyUjAQmAlUso
         RSlS+WI7E38gMDsUqsRtU4OD+Ys4ZjJglddmej7u+/TgIlRdwYVbpeP9MipeXIk5qaL8
         5/qSPpf56WsVm3A67bWCEMA7mT5Tn06jIepyF3j2aE13uxMiSCdtdpMjMw2xmQi8ro1I
         GlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758766050; x=1759370850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3v0KAw/a5VLZK8q/426U2Svx1Ly/zqTFJD1qMEvdMs=;
        b=a4qu15V8Ff96yfp1rKubAh9wB9qhEsUi568QwWVcPv/5NAQv8Vm2LpuMugW++8iHaF
         CTtXy1Tl2jvTWm1kOn9YCyUAM0g7qPBr4p0gcmVxkPRr4qETrR3AxR34Hj5B47SlmMER
         X86UmGQKpxBhK9bICFUdG9Wuj2ui+TotOj2W46BizWQZBQ/xEfqJhtZJkR4LpL3SsVZw
         LkUNoOC33zV65vcJ7F39VildJsfkunfC+QpTKMNvgS5hHSpdGpOrpX6OJEWb5myxfwKj
         6LExcAX7n524O46T6nAKkM1PPbowNRAaQHcfPQz6uSKqYrSQOf4Znj7vXrKDQKPMXpgT
         611Q==
X-Forwarded-Encrypted: i=1; AJvYcCVni/z9Jqfr/QW5zqsXjJ4q+tx9ApqajlRveLHP7yxbVRgjrSyfpInDd7CVAZxw3appchwxivjqm9SLhcICII+7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9db7Z1StHp7uTXDtk4D0PQUiSe2onOM0Pon3L4pz8Dd2lAqtI
	Oogu/0eCVskqGU4Z9+B9yV2sNuVykpmBuHDLbDyX3T26TPtHvvM6OWsX
X-Gm-Gg: ASbGnctGWEgilzsYzP+5b6PyhRqR2Uuuun7dP5f8F8MbwmU4mt7yWkdQ185EZoUJJ4V
	GjddMAERSACrlC4yL4oSddmY8wTiLbPDhw8kGFVodenBnv/Hm4PhdVnjTzO4ptK+B1zdGiQl9jk
	zNn/YkYP9Ea+we0QkvJLyOSuUVHCYWaEjk4xwQVumFW6FttXuCcMIyB4GLayYQCspvNNMTblgxC
	a4aZWWSbdaJupiFEbuMUq3b5yiN4bh0hqALTxkt63xTsx+TSMyu7FD4KOYgFdqrHPnxdMU4KLi4
	UWmAyPVRt3bFlLhD/4D4C5B++xXtUMuGg53//oUHoPrG9Gub0s9iT6wVmZaO4Smu2Nn3KSq3twF
	KissfShII8tJFFTVFYR1JVsenRurn0S5Siw==
X-Google-Smtp-Source: AGHT+IHZwY+E9Zl/mOnS/wW2XcXo5Et3bKXZYRlw/VXukF+oo1CmX+XrzU+9/LJydGwruFBdmu625g==
X-Received: by 2002:a17:902:fccf:b0:273:31fb:a872 with SMTP id d9443c01a7336-27ed4a06cefmr13125795ad.6.1758766049602;
        Wed, 24 Sep 2025 19:07:29 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6abff9fsm6469775ad.133.2025.09.24.19.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:07:28 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:07:26 +0800
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
Subject: Re: [PATCH v5 06/23] mm/ksw: add singleton /proc/kstackwatch
 interface
Message-ID: <aNSj3j1P9O-XWbRE@mdev>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
 <20250924115124.194940-7-wangjinchao600@gmail.com>
 <CANpmjNOuA3q3BweB9kTUpAX4CX1U25Pqa0Hiyt__=7zio81=Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOuA3q3BweB9kTUpAX4CX1U25Pqa0Hiyt__=7zio81=Uw@mail.gmail.com>

On Wed, Sep 24, 2025 at 10:49:35PM +0200, Marco Elver wrote:
> On Wed, 24 Sept 2025 at 13:51, Jinchao Wang <wangjinchao600@gmail.com> wrote:
> >
> > Provide the /proc/kstackwatch file to read or update the configuration.
> > Only a single process can open this file at a time, enforced using atomic
> > config_file_busy, to prevent concurrent access.
> 
> Why is this in /proc and not debugfs?
Thanks, will fix in next version.
> 
> > ksw_get_config() exposes the configuration pointer as const.
> >
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  mm/kstackwatch/kernel.c      | 77 +++++++++++++++++++++++++++++++++++-
> >  mm/kstackwatch/kstackwatch.h |  3 ++
> >  2 files changed, 79 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
> > index 3b7009033dd4..4a06ddadd9c7 100644
> > --- a/mm/kstackwatch/kernel.c
> > +++ b/mm/kstackwatch/kernel.c
> > @@ -3,11 +3,15 @@
> >
> >  #include <linux/kstrtox.h>
> >  #include <linux/module.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/string.h>
> > +#include <linux/uaccess.h>
> >
> >  #include "kstackwatch.h"
> >
> >  static struct ksw_config *ksw_config;
> > +static atomic_t config_file_busy = ATOMIC_INIT(0);
> >
> >  struct param_map {
> >         const char *name;       /* long name */
> > @@ -74,7 +78,7 @@ static int ksw_parse_param(struct ksw_config *config, const char *key,
> >   * - sp_offset  |so (u16) : offset from stack pointer at func_offset
> >   * - watch_len  |wl (u16) : watch length (1,2,4,8)
> >   */
> > -static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
> > +static int ksw_parse_config(char *buf, struct ksw_config *config)
> >  {
> >         char *part, *key, *val;
> >         int ret;
> > @@ -109,18 +113,89 @@ static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
> >         return 0;
> >  }
> >
> > +static ssize_t kstackwatch_proc_write(struct file *file,
> > +                                     const char __user *buffer, size_t count,
> > +                                     loff_t *pos)
> > +{
> > +       char input[MAX_CONFIG_STR_LEN];
> > +       int ret;
> > +
> > +       if (count == 0 || count >= sizeof(input))
> > +               return -EINVAL;
> > +
> > +       if (copy_from_user(input, buffer, count))
> > +               return -EFAULT;
> > +
> > +       input[count] = '\0';
> > +       strim(input);
> > +
> > +       if (!strlen(input)) {
> > +               pr_info("config cleared\n");
> > +               return count;
> > +       }
> > +
> > +       ret = ksw_parse_config(input, ksw_config);
> > +       if (ret) {
> > +               pr_err("Failed to parse config %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return count;
> > +}
> > +
> > +static int kstackwatch_proc_show(struct seq_file *m, void *v)
> > +{
> > +       seq_printf(m, "%s\n", ksw_config->user_input);
> > +       return 0;
> > +}
> > +
> > +static int kstackwatch_proc_open(struct inode *inode, struct file *file)
> > +{
> > +       if (atomic_cmpxchg(&config_file_busy, 0, 1))
> > +               return -EBUSY;
> > +
> > +       return single_open(file, kstackwatch_proc_show, NULL);
> > +}
> > +
> > +static int kstackwatch_proc_release(struct inode *inode, struct file *file)
> > +{
> > +       atomic_set(&config_file_busy, 0);
> > +       return single_release(inode, file);
> > +}
> > +
> > +static const struct proc_ops kstackwatch_proc_ops = {
> > +       .proc_open = kstackwatch_proc_open,
> > +       .proc_read = seq_read,
> > +       .proc_write = kstackwatch_proc_write,
> > +       .proc_lseek = seq_lseek,
> > +       .proc_release = kstackwatch_proc_release,
> > +};
> > +
> > +const struct ksw_config *ksw_get_config(void)
> > +{
> > +       return ksw_config;
> > +}
> >  static int __init kstackwatch_init(void)
> >  {
> >         ksw_config = kzalloc(sizeof(*ksw_config), GFP_KERNEL);
> >         if (!ksw_config)
> >                 return -ENOMEM;
> >
> > +       if (!proc_create("kstackwatch", 0600, NULL, &kstackwatch_proc_ops)) {
> > +               pr_err("create proc kstackwatch fail");
> > +               kfree(ksw_config);
> > +               return -ENOMEM;
> > +       }
> > +
> >         pr_info("module loaded\n");
> >         return 0;
> >  }
> >
> >  static void __exit kstackwatch_exit(void)
> >  {
> > +       remove_proc_entry("kstackwatch", NULL);
> > +       kfree(ksw_config->func_name);
> > +       kfree(ksw_config->user_input);
> >         kfree(ksw_config);
> >
> >         pr_info("module unloaded\n");
> > diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
> > index a7bad207f863..983125d5cf18 100644
> > --- a/mm/kstackwatch/kstackwatch.h
> > +++ b/mm/kstackwatch/kstackwatch.h
> > @@ -29,4 +29,7 @@ struct ksw_config {
> >         char *user_input;
> >  };
> >
> > +// singleton, only modified in kernel.c
> > +const struct ksw_config *ksw_get_config(void);
> > +
> >  #endif /* _KSTACKWATCH_H */
> > --
> > 2.43.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250924115124.194940-7-wangjinchao600%40gmail.com.

-- 
Jinchao
