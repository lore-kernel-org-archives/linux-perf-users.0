From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Broken dwarf unwinding - wrong stack pointer register value?
Date: Mon, 22 Oct 2018 06:58:17 -0700
Message-ID: <87o9bmrsli.fsf@linux.intel.com>
References: <2335309.gnWok9HYb4@agathebauer> <3129539.p6j0Z5hDSJ@agathebauer>
        <1775744.0RuD2nMEIt@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1775744.0RuD2nMEIt@agathebauer> (Milian Wolff's message of "Mon,
        22 Oct 2018 13:17:42 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Milian Wolff <mail@milianw.de>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:
>
> After more digging, it turns out that I've apparently chased a red herring. 
> I'm running archlinux which isn't shipping debug symbols for libm.

64bit executables normally have unwind information even when stripped.
Unless someone forcefully stripped those too.

You can checkout with objdump --sections.

-Andi
