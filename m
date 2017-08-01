From: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 07/18] tools headers: Fixup tools/include/uapi/linux/bpf.h
 copy of kernel ABI header
Date: Tue, 01 Aug 2017 22:15:54 +0200
Message-ID: <5980E17A.5020704@iogearbox.net>
References: <20170801195645.16986-1-acme@kernel.org> <20170801195645.16986-8-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from www62.your-server.de ([213.133.104.62]:33331 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbdHAUP4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2017 16:15:56 -0400
In-Reply-To: <20170801195645.16986-8-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

On 08/01/2017 09:56 PM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> In 04df41e343db ("bpf: update tools/include/uapi/linux/bpf.h") the files
> added in 40304b2a1567 ("bpf: BPF support for sock_ops") were added to
> tools/include, but not in a verbatim way, missing the comments, which
> ends up triggering this warning when build tools/perf/:
>
>    make: Entering directory '/home/acme/git/linux/tools/perf'
>      BUILD:   Doing 'make -j4' parallel build
>    Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'
>
> Make sure the the lines are equal, to fix the simple header copy
> drift detector in tools/perf/.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Lawrence Brakmo <brakmo@fb.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Fixes: 04df41e343db ("bpf: update tools/include/uapi/linux/bpf.h")
> Link: http://lkml.kernel.org/n/tip-z9qyyqht9qq3yyxu76sfy0dh@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
