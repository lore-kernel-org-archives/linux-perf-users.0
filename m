From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Php-fpm will crash when perf runs with call graph option
Date: Wed, 10 Jan 2018 16:21:49 +0100
Message-ID: <20180110152149.GA6316@krava>
References: <1514185003-17428-1-git-send-email-ufo19890607@gmail.com>
 <20171225213846.GA25478@krava>
 <CAHCio2jmTjgqR4V7q66dNaLrh7_o=sLMWK9K3FXPaUAT4-Ai+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCio2jmTjgqR4V7q66dNaLrh7_o=sLMWK9K3FXPaUAT4-Ai+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Wind Yu <yuzhoujian@didichuxing.com>, Adrian Hunter <adrian.hunter@intel.com>, Wang Nan <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Dec 26, 2017 at 10:29:34AM +0800, 禹舟键 wrote:
> Hi, Jirka
> This issue happens  always. The perf is running on the host machine and the
> command line is as follow:
> 
>          $perf record -ag -F 100
> 
> But I do not find anything about race condition from the call stack in gdb.
> The only thing I find is that some functions' rbp is really strange(0x1,
> 0x31).
> 
> There is a simple method to reproduce this issue. Just run a docker in a
> server(OS : centos7.3), and run php-fpm(php-7.0.6)  in the docker, then run
> some shell scripts from another server to send data package to the php-fpm
> in the docker. When perf runs on the server which contains the docker, the
> php-fpm will crash in just several seconds.

could you provide exact steps/commands for this?

thanks,
jirka
