From: Tony Jones <tonyj@suse.com>
Subject: Re: [PATCH v2] perf script/python: add new compaction-times script
Date: Fri, 21 Aug 2015 08:56:39 -0700
Message-ID: <55D74A37.5020104@suse.com>
References: <55C9BCC1.4030202@suse.cz> <1439840932-8933-1-git-send-email-tonyj@suse.com> <55D59EE4.7040705@suse.cz> <20150820194242.GD3154@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150820194242.GD3154@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mel Gorman <mgorman@suse.com>
List-Id: linux-perf-users.vger.kernel.org

On 08/20/2015 12:42 PM, Arnaldo Carvalho de Melo wrote:
 
> Well, we don't have any firm set standard for outputting from scripts,
> so if you did it inspired by existing scripts outputs, probably that is
> good enough, having someone testing it is a plus, and in these cases, if
> the "works for me" means you actually tested it, can we replace the
> "Acked-by" with a "Tested-by"?

The output seemed consistent with the existing scripts in that, as you point out, there really isn't much consistency. Taking a second look, the only thing I can see is that scripts such as futex-contention and failed-syscalls-by-pid output "comm *[pid]" whereas I'm outputting "pid[comm]".   That's certainly easy to change.

Yes, I believe Vlastimil tested v1 and v2 but I'll let him speak to this and to whether his approval goes beyond testing (re: acked-by).  

thanks

tony
