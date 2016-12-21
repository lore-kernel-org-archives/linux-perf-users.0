From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Inlined functions in perf report
Date: Wed, 21 Dec 2016 23:58:13 +0100
Message-ID: <20161221225813.GA8236@sesse.net>
References: <20161220115954.GA35897@sesse.net>
 <df263fe1-e1af-881b-311e-5329bb51db0e@linux.intel.com>
 <20161221095823.GA19249@sesse.net>
 <8193556.VWj3dM7HSI@milian-kdab2>
 <20161221102035.GA31703@sesse.net>
 <499d963f-9049-0b6c-00c3-0f155433ae26@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <499d963f-9049-0b6c-00c3-0f155433ae26@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Dec 22, 2016 at 06:56:28AM +0800, Jin, Yao wrote:
> Could you see the inline if you use the addr2line command? For example,
> addr2line -e <app> -i <addr>

I'm sorry, I don't have this profile anymore. I'll try again once we sort out
the problems of the DWARF error messages everywhere.

/* Steinar */
-- 
Homepage: https://www.sesse.net/
