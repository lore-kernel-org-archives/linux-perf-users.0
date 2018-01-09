From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] tracing: make sure the parsed string always
 terminates with '\0'
Date: Tue, 9 Jan 2018 18:02:58 -0500
Message-ID: <20180109180258.3936e10a@vmware.local.home>
References: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
        <1515491748-25926-3-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1515491748-25926-3-git-send-email-changbin.du@intel.com>
Sender: stable-owner@vger.kernel.org
To: changbin.du@intel.com
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue,  9 Jan 2018 17:55:47 +0800
changbin.du@intel.com wrote:

> From: Changbin Du <changbin.du@intel.com>
> 
> The parser parse every string into parser.buffer. And some of the callers
> assume that parser.buffer contains a C string. So it is dangerous that the
> parser returns a unterminated string. The userspace can leverage this to
> attack the kernel.

Is this only a bug if we apply your first patch?

-- Steve
