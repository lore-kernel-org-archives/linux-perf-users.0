From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 08/20] tools lib api fs: Fix gcc9 stringop-truncation
 compilation error
Date: Tue, 7 Jan 2020 10:16:50 +0100
Message-ID: <20200107091650.dydvcjnve7hz2345@pathway.suse.cz>
References: <20200106160705.10899-1-acme@kernel.org>
 <20200106160705.10899-9-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200106160705.10899-9-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andrey Zhizhikin <andrey.z@gmail.com>, Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Kefeng Wang <wangkefeng.wang@huawei.com>, Martin KaFai Lau <kafai@fb.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon 2020-01-06 13:06:53, Arnaldo Carvalho de Melo wrote:
> From: Andrey Zhizhikin <andrey.z@gmail.com>
> 
> GCC9 introduced string hardening mechanisms, which exhibits the error
> during fs api compilation:
> 
> error: '__builtin_strncpy' specified bound 4096 equals destination size
> [-Werror=stringop-truncation]
> 
> This comes when the length of copy passed to strncpy is is equal to
> destination size, which could potentially lead to buffer overflow.
> 
> There is a need to mitigate this potential issue by limiting the size of
> destination by 1 and explicitly terminate the destination with NULL.
> 
> Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: bpf@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Link: http://lore.kernel.org/lkml/20191211080109.18765-1-andrey.zhizhikin@leica-geosystems.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
