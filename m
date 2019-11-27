From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH] libbpf: Use PRIu64 for sym->st_value to fix build on
 32-bit arches
Date: Wed, 27 Nov 2019 08:39:28 -0800
Message-ID: <CAADnVQKkEqhdTOxytVbcm1QnBcf4MQ+q4KYaHzsuqkq3r=X-VA@mail.gmail.com>
References: <20191126183451.GC29071@kernel.org> <87d0dexyij.fsf@toke.dk>
 <20191126190450.GD29071@kernel.org> <CAEf4Bzbq3J9g7cP=KMqR=bMFcs=qPiNZwnkvCKz3-SAp_m0GzA@mail.gmail.com>
 <20191126221018.GA22719@kernel.org> <20191126221733.GB22719@kernel.org>
 <CAEf4BzbZLiJnUb+BdUMEwcgcKCjJBWx1895p8qS8rK2r5TYu3w@mail.gmail.com>
 <20191126231030.GE3145429@mini-arch.hsd1.ca.comcast.net> <20191126155228.0e6ed54c@cakuba.netronome.com>
 <20191127013901.GE29071@kernel.org> <20191127134553.GC22719@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191127134553.GC22719@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Stanislav Fomichev <sdf@fomichev.me>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, Andrii Nakryiko <andriin@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Quentin Monnet <quentin.monnet@netronome.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Nov 27, 2019 at 5:45 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Another fix I'm carrying in my perf/core branch,

Why in perf/core?
I very much prefer all libbpf patches to go via normal route via bpf/net trees.
We had enough conflicts in this merge window. Let's avoid them.
