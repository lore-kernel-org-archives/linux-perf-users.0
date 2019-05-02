From: Y Song <ys114321@gmail.com>
Subject: Re: [PATCH v2] tools/bpf: fix perf build error with uClibc (seen on ARC)
Date: Thu, 2 May 2019 13:19:27 -0700
Message-ID: <CAH3MdRWkiFSRA+PRo53_Syx9OBmyj2U_ebap-9iBR8L7xW9UVw@mail.gmail.com>
References: <CAH3MdRVkUFfwKkgT-pi-RLBpcEf6n0bAwWZOu-=7+qctPTCpkw@mail.gmail.com>
 <1556812610-27957-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556812610-27957-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>, Wang Nan <wangnan0@huawei.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-snps-arc@lists.infradead.org, linux-perf-users@vger.kernel.org, arnaldo.melo@gmail.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 2, 2019 at 8:57 AM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> When build perf for ARC recently, there was a build failure due to lack
> of __NR_bpf.
>
> | Auto-detecting system features:
> |
> | ...                     get_cpuid: [ OFF ]
> | ...                           bpf: [ on  ]
> |
> | #  error __NR_bpf not defined. libbpf does not support your arch.
>     ^~~~~
> | bpf.c: In function 'sys_bpf':
> | bpf.c:66:17: error: '__NR_bpf' undeclared (first use in this function)
> |  return syscall(__NR_bpf, cmd, attr, size);
> |                 ^~~~~~~~
> |                 sys_bpf
>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> v1 -> v2
>   - Only add syscall nr for ARC, as asm-generic won't work with arm/sh [Y Song]
> ---
>  tools/lib/bpf/bpf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9cd015574e83..d82edadf7589 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -46,6 +46,8 @@
>  #  define __NR_bpf 349
>  # elif defined(__s390__)
>  #  define __NR_bpf 351
> +# elif defined(__arc__)
> +#  define __NR_bpf 280
>  # else
>  #  error __NR_bpf not defined. libbpf does not support your arch.
>  # endif
> --
> 2.7.4
>
