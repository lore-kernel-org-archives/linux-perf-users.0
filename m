From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 0/5] Perf tool fixes for ARC + uClibc
Date: Wed, 14 Jan 2015 13:00:00 +0100
Message-ID: <20150114120000.GB11443@krava.brq.redhat.com>
References: <1421156604-30603-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421156604-30603-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, Alexey.Brodkin@synopsys.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jan 13, 2015 at 07:13:19PM +0530, Vineet Gupta wrote:
> Hi,
> 
> This series based off linux-next of 20150105 allows us to build/use perf
> for ARC with uClibc based userland.
> 
> v3: Changes since v2 [2]
> * 1/5	: Ack from Jiri
> * 2/5	: no changes
> * 3/5	: sys/syscall.h included	  [Jiri]
> * 4/5	: no changes
> * 5/5	: -lpthread added to link target  [Jiri]
> * {1,5} : Changelog updated so scissor lines don't start at column 1

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
