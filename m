From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
Date: Tue, 26 Nov 2019 17:38:18 +0100
Message-ID: <87imn6y4n9.fsf@toke.dk>
References: <20191126151045.GB19483@kernel.org> <20191126154836.GC19483@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191126154836.GC19483@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Andrii Nakryiko <andriin@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:

> Em Tue, Nov 26, 2019 at 12:10:45PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Hi guys,
>>=20
>>    While merging perf/core with mainline I found the problem below for
>> which I'm adding this patch to my perf/core branch, that soon will go
>> Ingo's way, etc. Please let me know if you think this should be handled
>> some other way,
>
> This is still not enough, fails building in a container where all we
> have is the tarball contents, will try to fix later.

Wouldn't the right thing to do not be to just run the script, and then
put the generated bpf_helper_defs.h into the tarball?

-Toke
