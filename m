From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/5] perf-probe: Improve probing on versioned symbols
Date: Thu, 7 Dec 2017 10:13:28 +0530
Message-ID: <0db660f7-2211-39b0-7491-7fb3cc4fbb8f@linux.vnet.ibm.com>
References: <151252958056.12861.954203514347167563.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <151252958056.12861.954203514347167563.stgit@devbox>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>, linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Masami,


On 12/06/2017 08:36 AM, Masami Hiramatsu wrote:
> [4/5] Find versioned symbol from map without wildcard.
>    This allows user to specify a symbol without version
>    suffix nor wildcard. Anyway, at this point we have
>    no way to specify version suffix, because parser
>    recognizes "@" is a separator of "function@file"
>    syntax. This is fixed in next patch.
> [5/5] Allow user to use backslash-escaped characters
>    on command line. This has 2 effects, user can specify
>    version suffix directly, and we can use special
>    characters in source file.

Just a thought. Will it be good to describe / illustrate this
in man page as well?

Thanks,
Ravi

