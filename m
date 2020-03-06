From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Date: Fri, 6 Mar 2020 18:56:42 -0300
Message-ID: <20200306215642.GA15931@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, John Garry <john.garry@huawei.com>, Nick Desaulniers <nick.desaulniers@gmail.com>, Tommi Rantala <tommi.t.rantala@nokia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Mar 06, 2020 at 04:11:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,

OOps, messed up and sent more messages than needed, the branch should be
ok tho:

[acme@quaco perf]$ git log --oneline acme/perf/urgent tip/perf/urgent..perf-urgent-for-mingo-5.6-20200306
441b62acd9c8 (tag: perf-urgent-for-mingo-5.6-20200306, five/perf/urgent, acme/perf/urgent, acme.korg/perf/urgent) tools: Fix off-by 1 relative directory includes
3f5777fbaf04 perf jevents: Fix leak of mapfile memory
7b919a53102d perf bench: Clear struct sigaction before sigaction() syscall
f649bd9dd5d5 perf bench futex-wake: Restore thread count default to online CPU count
29b4f5f18857 perf top: Fix stdio interface input handling with glibc 2.28+
cfd3bc752a3f perf diff: Fix undefined string comparision spotted by clang's -Wstring-compare
[acme@quaco perf]$

Sorry about that,

- Arnaldo
