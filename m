From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf record: use unmapped IP for inline callchain cursors
Date: Fri, 5 Oct 2018 10:48:31 -0300
Message-ID: <20181005134831.GA20250@kernel.org>
References: <20181002073949.3297-1-milian.wolff@kdab.com>
 <20181002153236.GD3541@kernel.org>
 <f71ed02b-1234-db9c-6a48-1a399359b5e8@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f71ed02b-1234-db9c-6a48-1a399359b5e8@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Oct 03, 2018 at 09:05:37AM +0530, Ravi Bangoria escreveu:
> LGTM.
 
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

So, I've added this as a 'git rebase -i' 'fixup', i.e. kept the commit
log message for the patch this patch fixes, and combined the two into
just one patch so that we don't pollute the bisect history, since this
hasn't made it yet to tip, and I also added Ravi's Tested-by, since this
tests both.

- Arnaldo
