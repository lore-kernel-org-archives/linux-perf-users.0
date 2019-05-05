From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2] tools/bpf: fix perf build error with uClibc (seen on ARC)
Date: Sun, 5 May 2019 00:05:06 -0700
Message-ID: <CAADnVQKOR7NJ=zDLndJpTnVjnkjr1UrtWG_2vwgJK3QcCAADcA@mail.gmail.com>
References: <CAH3MdRVkUFfwKkgT-pi-RLBpcEf6n0bAwWZOu-=7+qctPTCpkw@mail.gmail.com>
 <1556812610-27957-1-git-send-email-vgupta@synopsys.com> <CAH3MdRWkiFSRA+PRo53_Syx9OBmyj2U_ebap-9iBR8L7xW9UVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAH3MdRWkiFSRA+PRo53_Syx9OBmyj2U_ebap-9iBR8L7xW9UVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Y Song <ys114321@gmail.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>, Wang Nan <wangnan0@huawei.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-snps-arc@lists.infradead.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 2, 2019 at 1:20 PM Y Song <ys114321@gmail.com> wrote:
>
> On Thu, May 2, 2019 at 8:57 AM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> >
> > When build perf for ARC recently, there was a build failure due to lack
> > of __NR_bpf.
> >
> > | Auto-detecting system features:
> > |
> > | ...                     get_cpuid: [ OFF ]
> > | ...                           bpf: [ on  ]
> > |
> > | #  error __NR_bpf not defined. libbpf does not support your arch.
> >     ^~~~~
> > | bpf.c: In function 'sys_bpf':
> > | bpf.c:66:17: error: '__NR_bpf' undeclared (first use in this function)
> > |  return syscall(__NR_bpf, cmd, attr, size);
> > |                 ^~~~~~~~
> > |                 sys_bpf
> >
> > Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Applied. Thanks
