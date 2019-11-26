From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
Date: Tue, 26 Nov 2019 19:50:44 +0100
Message-ID: <87d0dexyij.fsf@toke.dk>
References: <20191126151045.GB19483@kernel.org> <20191126154836.GC19483@kernel.org> <87imn6y4n9.fsf@toke.dk> <20191126183451.GC29071@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191126183451.GC29071@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Andrii Nakryiko <andriin@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:

> Em Tue, Nov 26, 2019 at 05:38:18PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n escreveu:
>> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
>>=20
>> > Em Tue, Nov 26, 2019 at 12:10:45PM -0300, Arnaldo Carvalho de Melo esc=
reveu:
>> >> Hi guys,
>> >>=20
>> >>    While merging perf/core with mainline I found the problem below fo=
r
>> >> which I'm adding this patch to my perf/core branch, that soon will go
>> >> Ingo's way, etc. Please let me know if you think this should be handl=
ed
>> >> some other way,
>> >
>> > This is still not enough, fails building in a container where all we
>> > have is the tarball contents, will try to fix later.
>>=20
>> Wouldn't the right thing to do not be to just run the script, and then
>> put the generated bpf_helper_defs.h into the tarball?
>
> I would rather continue just running tar and have the build process
> in-tree or outside be the same.

Hmm, right. Well that Python script basically just parses
include/uapi/linux/bpf.h; and it can be given the path of that file with
the --filename argument. So as long as that file is present, it should
be possible to make it work, I guess?

However, isn't the point of the tarball to make a "stand-alone" source
distribution? I'd argue that it makes more sense to just include the
generated header, then: The point of the Python script is specifically
to extract the latest version of the helper definitions from the kernel
source tree. And if you're "freezing" a version into a tarball, doesn't
it make more sense to also freeze the list of BPF helpers?

-Toke
