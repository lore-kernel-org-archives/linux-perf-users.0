From: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 04/18] tools headers: Fixup tools/include/uapi/linux/bpf.h
 copy of kernel ABI header
Date: Tue, 01 Aug 2017 22:15:16 +0200
Message-ID: <5980E154.2080303@iogearbox.net>
References: <20170801195645.16986-1-acme@kernel.org> <20170801195645.16986-5-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from www62.your-server.de ([213.133.104.62]:33211 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbdHAUPT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2017 16:15:19 -0400
In-Reply-To: <20170801195645.16986-5-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

On 08/01/2017 09:56 PM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> In 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper") BPF_ADJ_ROOM_NET was
> added to include/uapi/linux/bpf.h but BPF_ADJ_ROOM_NET_OPS was added to
> tools/include/uapi/linux/bpf.h, making these files differ, fix it by using the
> same name in both, BPF_ADJ_ROOM_NET, the one in the kernel headers copy.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
> Link: http://lkml.kernel.org/n/tip-2bmwovi9lymplyz6wsszppyf@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
