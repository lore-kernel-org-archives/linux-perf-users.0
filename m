From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
Date: Tue, 26 Nov 2019 15:52:28 -0800
Message-ID: <20191126155228.0e6ed54c@cakuba.netronome.com>
References: <20191126151045.GB19483@kernel.org>
        <20191126154836.GC19483@kernel.org>
        <87imn6y4n9.fsf@toke.dk>
        <20191126183451.GC29071@kernel.org>
        <87d0dexyij.fsf@toke.dk>
        <20191126190450.GD29071@kernel.org>
        <CAEf4Bzbq3J9g7cP=KMqR=bMFcs=qPiNZwnkvCKz3-SAp_m0GzA@mail.gmail.com>
        <20191126221018.GA22719@kernel.org>
        <20191126221733.GB22719@kernel.org>
        <CAEf4BzbZLiJnUb+BdUMEwcgcKCjJBWx1895p8qS8rK2r5TYu3w@mail.gmail.com>
        <20191126231030.GE3145429@mini-arch.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191126231030.GE3145429@mini-arch.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Andrii Nakryiko <andriin@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Quentin Monnet <quentin.monnet@netronome.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, 26 Nov 2019 15:10:30 -0800, Stanislav Fomichev wrote:
> We are using this script with python2.7, works just fine :-)
> So maybe doing s/python3/python/ is the way to go, whatever
> default python is installed, it should work with that.

That increases the risk someone will make a python2-only change 
and break Python 3.

Python 2 is dead, I'm honestly surprised this needs to be said :)
